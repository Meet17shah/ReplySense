import 'package:cloud_firestore/cloud_firestore.dart';

/// User Profile Model for storing user information and preferences
class UserProfileModel {
  final String userId;
  final String email;
  final String displayName;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final UserPreferences preferences;
  final UserStatistics statistics;

  UserProfileModel({
    required this.userId,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.createdAt,
    required this.lastLoginAt,
    required this.preferences,
    required this.statistics,
  });

  /// Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginAt': Timestamp.fromDate(lastLoginAt),
      'preferences': preferences.toMap(),
      'statistics': statistics.toMap(),
    };
  }

  /// Create from Firebase document
  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLoginAt: (map['lastLoginAt'] as Timestamp).toDate(),
      preferences: UserPreferences.fromMap(map['preferences'] ?? {}),
      statistics: UserStatistics.fromMap(map['statistics'] ?? {}),
    );
  }

  /// Create a copy with updated fields
  UserProfileModel copyWith({
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    UserPreferences? preferences,
    UserStatistics? statistics,
  }) {
    return UserProfileModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      preferences: preferences ?? this.preferences,
      statistics: statistics ?? this.statistics,
    );
  }
}

/// User Preferences sub-model
class UserPreferences {
  final String defaultTone;
  final String defaultCategory;
  final bool emailNotifications;
  final bool showOnboarding;

  UserPreferences({
    this.defaultTone = 'Professional',
    this.defaultCategory = 'General',
    this.emailNotifications = true,
    this.showOnboarding = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'defaultTone': defaultTone,
      'defaultCategory': defaultCategory,
      'emailNotifications': emailNotifications,
      'showOnboarding': showOnboarding,
    };
  }

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      defaultTone: map['defaultTone'] ?? 'Professional',
      defaultCategory: map['defaultCategory'] ?? 'General',
      emailNotifications: map['emailNotifications'] ?? true,
      showOnboarding: map['showOnboarding'] ?? true,
    );
  }

  UserPreferences copyWith({
    String? defaultTone,
    String? defaultCategory,
    bool? emailNotifications,
    bool? showOnboarding,
  }) {
    return UserPreferences(
      defaultTone: defaultTone ?? this.defaultTone,
      defaultCategory: defaultCategory ?? this.defaultCategory,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      showOnboarding: showOnboarding ?? this.showOnboarding,
    );
  }
}

/// User Statistics sub-model
class UserStatistics {
  final int totalRepliesGenerated;
  final int totalEmailsAnalyzed;
  final int totalTemplatesCreated;
  final int templatesUsed;

  UserStatistics({
    this.totalRepliesGenerated = 0,
    this.totalEmailsAnalyzed = 0,
    this.totalTemplatesCreated = 0,
    this.templatesUsed = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalRepliesGenerated': totalRepliesGenerated,
      'totalEmailsAnalyzed': totalEmailsAnalyzed,
      'totalTemplatesCreated': totalTemplatesCreated,
      'templatesUsed': templatesUsed,
    };
  }

  factory UserStatistics.fromMap(Map<String, dynamic> map) {
    return UserStatistics(
      totalRepliesGenerated: map['totalRepliesGenerated'] ?? 0,
      totalEmailsAnalyzed: map['totalEmailsAnalyzed'] ?? 0,
      totalTemplatesCreated: map['totalTemplatesCreated'] ?? 0,
      templatesUsed: map['templatesUsed'] ?? 0,
    );
  }

  UserStatistics copyWith({
    int? totalRepliesGenerated,
    int? totalEmailsAnalyzed,
    int? totalTemplatesCreated,
    int? templatesUsed,
  }) {
    return UserStatistics(
      totalRepliesGenerated: totalRepliesGenerated ?? this.totalRepliesGenerated,
      totalEmailsAnalyzed: totalEmailsAnalyzed ?? this.totalEmailsAnalyzed,
      totalTemplatesCreated: totalTemplatesCreated ?? this.totalTemplatesCreated,
      templatesUsed: templatesUsed ?? this.templatesUsed,
    );
  }
}
