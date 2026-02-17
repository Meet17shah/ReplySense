/// Model for AI request data
class AIRequest {
  final String emailText;
  final String tone;
  final String userId;

  AIRequest({
    required this.emailText,
    required this.tone,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'emailText': emailText,
      'tone': tone,
      'userId': userId,
    };
  }
}

/// Model for AI response data
class AIResponse {
  final String summary;
  final List<String> replies;
  final List<String> todos;

  AIResponse({
    required this.summary,
    required this.replies,
    required this.todos,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      summary: json['summary'] as String,
      replies: List<String>.from(json['replies'] as List),
      todos: List<String>.from(json['todos'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'summary': summary,
      'replies': replies,
      'todos': todos,
    };
  }
}

/// Model for API result returned to UI
class ApiResult {
  final bool success;
  final AIResponse? data;
  final String? error;
  final int? remainingRequests;

  ApiResult({
    required this.success,
    this.data,
    this.error,
    this.remainingRequests,
  });

  factory ApiResult.success(AIResponse data, int remainingRequests) {
    return ApiResult(
      success: true,
      data: data,
      remainingRequests: remainingRequests,
    );
  }

  factory ApiResult.failure(String error) {
    return ApiResult(
      success: false,
      error: error,
    );
  }
}
