import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/ai_request_model.dart';
import 'rate_limit_service.dart';

class ApiService {
  final RateLimitService _rateLimitService = RateLimitService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Build the AI prompt with strict JSON instructions
  String _buildPrompt(String emailText, String tone) {
    const toneInstructions = {
      'professional': 'Use formal, business-appropriate language. Be polite and clear.',
      'friendly': 'Use warm, conversational language. Be approachable and positive.',
      'formal': 'Use highly formal, official language. Be precise and respectful.',
    };

    return '''You are an intelligent email assistant. Analyze the provided email and return ONLY valid JSON.

CRITICAL RULES:
- Return ONLY raw JSON
- NO markdown formatting
- NO code blocks
- NO explanations
- NO additional text
- The response must be directly parseable as JSON

REQUIRED JSON FORMAT:
{
  "summary": "3-5 sentence summary of the email",
  "replies": ["complete reply 1", "complete reply 2", "complete reply 3"],
  "todos": ["actionable task 1", "actionable task 2"]
}

RULES:
1. summary: Summarize the email in 3-5 clear, concise sentences
2. replies: Generate EXACTLY 3 complete, ready-to-send reply suggestions
3. todos: Extract ONLY actionable tasks or instructions from the email
4. If no tasks exist, todos must be an empty array: []
5. Tone for replies: ${toneInstructions[tone] ?? toneInstructions['professional']}

EMAIL TO ANALYZE:
$emailText

Remember: Return ONLY the JSON object, nothing else.''';
  }

  /// Validate input data
  String? _validateInput(String emailText, String tone, String userId) {
    if (emailText.trim().isEmpty) {
      return 'Email text cannot be empty';
    }

    if (emailText.trim().length < 10) {
      return 'Email text must be at least 10 characters';
    }

    if (emailText.trim().length > 10000) {
      return 'Email text cannot exceed 10,000 characters';
    }

    const allowedTones = ['professional', 'friendly', 'formal'];
    if (!allowedTones.contains(tone)) {
      return 'Invalid tone. Must be: professional, friendly, or formal';
    }

    if (userId.trim().isEmpty) {
      return 'User ID is required';
    }

    return null;
  }

  /// Parse and clean AI response
  AIResponse _parseAIResponse(String rawResponse) {
    try {
      // Clean up response - remove markdown code blocks if present
      String cleanedText = rawResponse.trim();

      if (cleanedText.startsWith('```json')) {
        cleanedText = cleanedText.replaceAll(RegExp(r'^```json\s*'), '').replaceAll(RegExp(r'```\s*$'), '');
      } else if (cleanedText.startsWith('```')) {
        cleanedText = cleanedText.replaceAll(RegExp(r'^```\s*'), '').replaceAll(RegExp(r'```\s*$'), '');
      }

      cleanedText = cleanedText.trim();

      // Parse JSON
      final Map<String, dynamic> parsed = jsonDecode(cleanedText);

      // Validate structure
      if (!parsed.containsKey('summary') || parsed['summary'] is! String) {
        throw Exception('AI response missing valid summary');
      }

      if (!parsed.containsKey('replies') || parsed['replies'] is! List) {
        throw Exception('AI response missing valid replies array');
      }

      final replies = List<String>.from(parsed['replies'] as List);
      if (replies.length != 3) {
        throw Exception('AI must return exactly 3 replies');
      }

      if (!parsed.containsKey('todos') || parsed['todos'] is! List) {
        throw Exception('AI response missing valid todos array');
      }

      final todos = List<String>.from(parsed['todos'] as List);

      return AIResponse(
        summary: (parsed['summary'] as String).trim(),
        replies: replies.map((r) => r.trim()).toList(),
        todos: todos.map((t) => t.trim()).toList(),
      );
    } catch (e) {
      print('Parse error: $e');
      print('Raw response: $rawResponse');
      throw Exception('Failed to parse AI response: ${e.toString()}');
    }
  }

  /// Save analysis result to Firestore
  Future<void> _saveToHistory({
    required String userId,
    required String emailText,
    required String tone,
    required AIResponse aiResponse,
  }) async {
    try {
      final historyRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('history');

      await historyRef.add({
        'userId': userId,
        'originalEmail': emailText,
        'summary': aiResponse.summary,
        'generatedReplies': aiResponse.replies,
        'selectedTone': tone,
        'timestamp': FieldValue.serverTimestamp(),
        'isArchived': false,
        'isFavorite': false,
        'analysisData': {
          'sentiment': 'Neutral',
          'urgency': 'Normal',
          'keyPoints': aiResponse.todos,
          'category': 'General',
        },
      });

      // Update user statistics
      final userRef = _firestore.collection('users').doc(userId);
      await userRef.update({
        'statistics.totalRepliesGenerated': FieldValue.increment(1),
        'statistics.totalEmailsAnalyzed': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error saving to history: $e');
      // Don't throw - history save failure shouldn't break the flow
    }
  }

  /// Analyze email using Gemini AI
  Future<ApiResult> analyzeEmail({
    required String emailText,
    required String tone,
    required String userId,
  }) async {
    try {
      // Validate input
      final validationError = _validateInput(emailText, tone, userId);
      if (validationError != null) {
        return ApiResult.failure(validationError);
      }

      // Check rate limit
      final rateLimitCheck = await _rateLimitService.checkRateLimit(userId);
      if (!rateLimitCheck['allowed']) {
        return ApiResult.failure(rateLimitCheck['error'] ?? 'Rate limit exceeded');
      }

      final remainingRequests = rateLimitCheck['remaining'] as int;

      // Build prompt
      final prompt = _buildPrompt(emailText, tone);

      // Call Gemini REST API - Using text generation endpoint (works with all API keys)
      print('Calling Gemini AI via REST API...');
      
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${ApiConfig.geminiApiKey}'
      );
      
      final requestBody = {
        'contents': [{
          'parts': [{
            'text': prompt
          }]
        }],
        'generationConfig': {
          'temperature': ApiConfig.aiTemperature,
          'maxOutputTokens': ApiConfig.maxOutputTokens,
        }
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode != 200) {
        print('API Error: ${response.statusCode} - ${response.body}');
        
        // Handle rate limit error specifically
        if (response.statusCode == 429) {
          return ApiResult.failure('Rate limit reached. Please wait 1-2 minutes and try again. The feature is working correctly!');
        }
        
        return ApiResult.failure('AI service error: ${response.statusCode}');
      }

      final responseData = jsonDecode(response.body);
      
      if (responseData['candidates'] == null || responseData['candidates'].isEmpty) {
        return ApiResult.failure('AI returned no response');
      }

      final textResponse = responseData['candidates'][0]['content']['parts'][0]['text'];
      
      if (textResponse == null || textResponse.isEmpty) {
        return ApiResult.failure('AI returned empty response');
      }

      print('AI Response received');

      // Parse response
      final aiResponse = _parseAIResponse(textResponse);

      // Save to Firestore
      await _saveToHistory(
        userId: userId,
        emailText: emailText,
        tone: tone,
        aiResponse: aiResponse,
      );

      return ApiResult.success(aiResponse, remainingRequests);
    } catch (e) {
      print('API Service Error: $e');

      if (e.toString().contains('API key')) {
        return ApiResult.failure('AI service configuration error');
      }

      if (e.toString().contains('quota') || e.toString().contains('limit')) {
        return ApiResult.failure('AI service quota exceeded. Please try again later.');
      }

      if (e.toString().contains('parse')) {
        return ApiResult.failure('Failed to process AI response. Please try again.');
      }

      return ApiResult.failure('Analysis failed: ${e.toString()}');
    }
  }
}
