import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/activity_model.dart';

/// Service for tracking and managing user activities and analytics
class AnalyticsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  /// Get activities collection reference for current user
  CollectionReference get _activitiesCollection {
    if (_currentUserId == null) {
      throw Exception('User not authenticated');
    }
    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('activities');
  }

  // ==================== CREATE ====================

  /// Log a new activity
  Future<void> logActivity({
    required String activityType,
    required String title,
    required String description,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      await _activitiesCollection.add({
        'userId': _currentUserId,
        'activityType': activityType,
        'title': title,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
        'metadata': metadata,
      });
    } catch (e) {
      throw Exception('Failed to log activity: $e');
    }
  }

  /// Log template creation activity
  Future<void> logTemplateCreated(String templateTitle) async {
    await logActivity(
      activityType: ActivityModel.typeTemplateCreated,
      title: 'New template created',
      description: templateTitle,
    );
  }

  /// Log reply generation activity
  Future<void> logReplyGenerated(String emailSummary) async {
    await logActivity(
      activityType: ActivityModel.typeReplyGenerated,
      title: 'Smart reply generated',
      description: emailSummary,
    );
  }

  /// Log email analysis activity
  Future<void> logEmailAnalyzed(String emailPreview) async {
    await logActivity(
      activityType: ActivityModel.typeEmailAnalyzed,
      title: 'Email analyzed',
      description: emailPreview,
    );
  }

  /// Log template usage activity
  Future<void> logTemplateUsed(String templateTitle) async {
    await logActivity(
      activityType: ActivityModel.typeTemplateUsed,
      title: 'Template used',
      description: templateTitle,
    );
  }

  // ==================== READ ====================

  /// Get recent activities stream
  Stream<List<ActivityModel>> getRecentActivitiesStream({int limit = 10}) {
    try {
      return _activitiesCollection
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return ActivityModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to get activities stream: $e');
    }
  }

  /// Get recent activities (one-time fetch)
  Future<List<ActivityModel>> getRecentActivities({int limit = 10}) async {
    try {
      final snapshot = await _activitiesCollection
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        return ActivityModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get recent activities: $e');
    }
  }

  /// Get activities by type
  Future<List<ActivityModel>> getActivitiesByType(
    String activityType, {
    int limit = 20,
  }) async {
    try {
      final snapshot = await _activitiesCollection
          .where('activityType', isEqualTo: activityType)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        return ActivityModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get activities by type: $e');
    }
  }

  // ==================== DELETE ====================

  /// Clear old activities (older than specified days)
  Future<void> clearOldActivities({int olderThanDays = 30}) async {
    try {
      final cutoffDate =
          DateTime.now().subtract(Duration(days: olderThanDays));

      final snapshot = await _activitiesCollection
          .where('timestamp', isLessThan: Timestamp.fromDate(cutoffDate))
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear old activities: $e');
    }
  }

  /// Delete all activities
  Future<void> clearAllActivities() async {
    try {
      final snapshot = await _activitiesCollection.get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear all activities: $e');
    }
  }
}
