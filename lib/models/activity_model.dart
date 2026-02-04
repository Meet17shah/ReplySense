import 'package:cloud_firestore/cloud_firestore.dart';

/// Activity Model for tracking user actions
class ActivityModel {
  final String id;
  final String userId;
  final String activityType; // 'template_created', 'reply_generated', 'email_analyzed', 'template_used'
  final String title;
  final String description;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.activityType,
    required this.title,
    required this.description,
    required this.timestamp,
    this.metadata,
  });

  /// Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'activityType': activityType,
      'title': title,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
      'metadata': metadata,
    };
  }

  /// Create from Firebase document
  factory ActivityModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ActivityModel(
      id: documentId,
      userId: map['userId'] ?? '',
      activityType: map['activityType'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      metadata: map['metadata'],
    );
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
    } else {
      return '${difference.inDays}d ago';
    }
  }

  /// Activity type constants
  static const String typeTemplateCreated = 'template_created';
  static const String typeReplyGenerated = 'reply_generated';
  static const String typeEmailAnalyzed = 'email_analyzed';
  static const String typeTemplateUsed = 'template_used';
}
