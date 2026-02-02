import 'package:cloud_firestore/cloud_firestore.dart';

/// Template Model for storing reply templates
/// Used for CRUD operations in Firebase Firestore
class TemplateModel {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final String userId;
  final int usageCount;
  final bool isFavorite;

  TemplateModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.userId,
    this.usageCount = 0,
    this.isFavorite = false,
  });

  /// Convert Template object to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
      'usageCount': usageCount,
      'isFavorite': isFavorite,
    };
  }

  /// Create Template object from Firebase document
  factory TemplateModel.fromMap(Map<String, dynamic> map, String documentId) {
    return TemplateModel(
      id: documentId,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? 'General',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      userId: map['userId'] ?? '',
      usageCount: map['usageCount'] ?? 0,
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  /// Create a copy of template with updated fields
  TemplateModel copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    String? userId,
    int? usageCount,
    bool? isFavorite,
  }) {
    return TemplateModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      usageCount: usageCount ?? this.usageCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Validate template data before saving
  static String? validateTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'Template title is required';
    }
    if (title.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    if (title.trim().length > 50) {
      return 'Title must not exceed 50 characters';
    }
    return null;
  }

  static String? validateContent(String? content) {
    if (content == null || content.trim().isEmpty) {
      return 'Template content is required';
    }
    if (content.trim().length < 10) {
      return 'Content must be at least 10 characters';
    }
    if (content.trim().length > 1000) {
      return 'Content must not exceed 1000 characters';
    }
    return null;
  }

  static String? validateCategory(String? category) {
    if (category == null || category.trim().isEmpty) {
      return 'Category is required';
    }
    return null;
  }

  /// Get content preview (first 50 characters)
  String get contentPreview {
    if (content.length <= 50) {
      return content;
    }
    return '${content.substring(0, 50)}...';
  }

  /// Available template categories
  static const List<String> categories = [
    'Professional',
    'Casual',
    'Apology',
    'Thank You',
    'Follow Up',
    'Meeting',
    'Introduction',
    'Rejection',
    'General',
  ];

  @override
  String toString() {
    return 'TemplateModel(id: $id, title: $title, category: $category, usageCount: $usageCount)';
  }
}
