import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile_model.dart';

/// Service for managing user profile operations in Firestore
class UserProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  /// Get user profile document reference
  DocumentReference get _profileDoc {
    if (_currentUserId == null) {
      throw Exception('User not authenticated');
    }
    return _firestore.collection('users').doc(_currentUserId);
  }

  // ==================== CREATE ====================

  /// Create initial user profile (called on first login/registration)
  Future<void> createUserProfile({
    required String userId,
    required String email,
    required String displayName,
    String? photoUrl,
  }) async {
    try {
      final profile = UserProfileModel(
        userId: userId,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        preferences: UserPreferences(),
        statistics: UserStatistics(),
      );

      await _firestore.collection('users').doc(userId).set(profile.toMap());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  // ==================== READ ====================

  /// Get user profile as stream (real-time updates)
  Stream<UserProfileModel?> getUserProfileStream() {
    try {
      return _profileDoc.snapshots().map((doc) {
        if (!doc.exists) return null;
        return UserProfileModel.fromMap(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception('Failed to get user profile stream: $e');
    }
  }

  /// Get user profile (one-time fetch)
  Future<UserProfileModel?> getUserProfile() async {
    try {
      final doc = await _profileDoc.get();
      if (!doc.exists) return null;
      return UserProfileModel.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Check if user profile exists
  Future<bool> userProfileExists() async {
    try {
      final doc = await _profileDoc.get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // ==================== UPDATE ====================

  /// Update user display name
  Future<void> updateDisplayName(String displayName) async {
    try {
      await _profileDoc.update({'displayName': displayName});
    } catch (e) {
      throw Exception('Failed to update display name: $e');
    }
  }

  /// Update user photo URL
  Future<void> updatePhotoUrl(String photoUrl) async {
    try {
      await _profileDoc.update({'photoUrl': photoUrl});
    } catch (e) {
      throw Exception('Failed to update photo URL: $e');
    }
  }

  /// Update user preferences
  Future<void> updatePreferences(UserPreferences preferences) async {
    try {
      await _profileDoc.update({'preferences': preferences.toMap()});
    } catch (e) {
      throw Exception('Failed to update preferences: $e');
    }
  }

  /// Update last login timestamp
  Future<void> updateLastLogin() async {
    try {
      await _profileDoc.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update last login: $e');
    }
  }

  // ==================== STATISTICS ====================

  /// Increment total replies generated
  Future<void> incrementRepliesGenerated() async {
    try {
      await _profileDoc.update({
        'statistics.totalRepliesGenerated': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment replies generated: $e');
    }
  }

  /// Increment total emails analyzed
  Future<void> incrementEmailsAnalyzed() async {
    try {
      await _profileDoc.update({
        'statistics.totalEmailsAnalyzed': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment emails analyzed: $e');
    }
  }

  /// Increment total templates created
  Future<void> incrementTemplatesCreated() async {
    try {
      await _profileDoc.update({
        'statistics.totalTemplatesCreated': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment templates created: $e');
    }
  }

  /// Increment templates used counter
  Future<void> incrementTemplatesUsed() async {
    try {
      await _profileDoc.update({
        'statistics.templatesUsed': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment templates used: $e');
    }
  }

  /// Update statistics in batch
  Future<void> updateStatistics(UserStatistics statistics) async {
    try {
      await _profileDoc.update({'statistics': statistics.toMap()});
    } catch (e) {
      throw Exception('Failed to update statistics: $e');
    }
  }

  // ==================== DELETE ====================

  /// Delete user profile (for account deletion)
  Future<void> deleteUserProfile() async {
    try {
      await _profileDoc.delete();
    } catch (e) {
      throw Exception('Failed to delete user profile: $e');
    }
  }
}
