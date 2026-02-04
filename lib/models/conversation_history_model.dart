import 'package:cloud_firestore/cloud_firestore.dart';

/// Conversation History Model for storing email analysis and generated replies
class ConversationHistoryModel {
  final String id;
  final String userId;
  final String originalEmail;
  final List<String> generatedReplies;
  final String selectedTone;
  final String summary;
  final EmailAnalysisData? analysisData;
  final DateTime timestamp;
  final bool isArchived;
  final bool isFavorite;

  ConversationHistoryModel({
    required this.id,
    required this.userId,
    required this.originalEmail,
    required this.generatedReplies,
    required this.selectedTone,
    required this.summary,
    this.analysisData,
    required this.timestamp,
    this.isArchived = false,
    this.isFavorite = false,
  });

  /// Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'originalEmail': originalEmail,
      'generatedReplies': generatedReplies,
      'selectedTone': selectedTone,
      'summary': summary,
      'analysisData': analysisData?.toMap(),
      'timestamp': Timestamp.fromDate(timestamp),
      'isArchived': isArchived,
      'isFavorite': isFavorite,
    };
  }

  /// Create from Firebase document
  factory ConversationHistoryModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return ConversationHistoryModel(
      id: documentId,
      userId: map['userId'] ?? '',
      originalEmail: map['originalEmail'] ?? '',
      generatedReplies: List<String>.from(map['generatedReplies'] ?? []),
      selectedTone: map['selectedTone'] ?? 'Professional',
      summary: map['summary'] ?? '',
      analysisData: map['analysisData'] != null
          ? EmailAnalysisData.fromMap(map['analysisData'])
          : null,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      isArchived: map['isArchived'] ?? false,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  /// Create a copy with updated fields
  ConversationHistoryModel copyWith({
    String? id,
    String? userId,
    String? originalEmail,
    List<String>? generatedReplies,
    String? selectedTone,
    String? summary,
    EmailAnalysisData? analysisData,
    DateTime? timestamp,
    bool? isArchived,
    bool? isFavorite,
  }) {
    return ConversationHistoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      originalEmail: originalEmail ?? this.originalEmail,
      generatedReplies: generatedReplies ?? this.generatedReplies,
      selectedTone: selectedTone ?? this.selectedTone,
      summary: summary ?? this.summary,
      analysisData: analysisData ?? this.analysisData,
      timestamp: timestamp ?? this.timestamp,
      isArchived: isArchived ?? this.isArchived,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Get preview of original email (first 100 characters)
  String get emailPreview {
    if (originalEmail.length <= 100) {
      return originalEmail;
    }
    return '${originalEmail.substring(0, 100)}...';
  }

  /// Get formatted timestamp
  String get formattedTimestamp {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

/// Email Analysis Data sub-model
class EmailAnalysisData {
  final String sentiment;
  final String urgency;
  final List<String> keyPoints;
  final String category;

  EmailAnalysisData({
    required this.sentiment,
    required this.urgency,
    required this.keyPoints,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'sentiment': sentiment,
      'urgency': urgency,
      'keyPoints': keyPoints,
      'category': category,
    };
  }

  factory EmailAnalysisData.fromMap(Map<String, dynamic> map) {
    return EmailAnalysisData(
      sentiment: map['sentiment'] ?? 'Neutral',
      urgency: map['urgency'] ?? 'Normal',
      keyPoints: List<String>.from(map['keyPoints'] ?? []),
      category: map['category'] ?? 'General',
    );
  }
}
