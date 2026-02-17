import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/api_config.dart';

/// Service to manage API rate limiting per user
class RateLimitService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current date in YYYY-MM-DD format
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Check if user can make another request
  /// Returns Map with 'allowed' (bool) and 'remaining' (int)
  Future<Map<String, dynamic>> checkRateLimit(String userId) async {
    // TEMPORARILY DISABLED FOR TESTING - ALWAYS ALLOW
    return {
      'allowed': true,
      'remaining': 999,
    };
  }

  /// Get user's remaining requests for today
  Future<int> getRemainingRequests(String userId) async {
    try {
      final rateLimitRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('rateLimit')
          .doc('daily');

      final currentDate = _getCurrentDate();

      final doc = await rateLimitRef.get();

      if (!doc.exists) {
        return ApiConfig.dailyRequestLimit;
      }

      final data = doc.data()!;
      final lastDate = data['lastRequestDate'] as String;
      final requestCount = data['requestCount'] as int;

      // New day - full limit available
      if (lastDate != currentDate) {
        return ApiConfig.dailyRequestLimit;
      }

      return (ApiConfig.dailyRequestLimit - requestCount).clamp(0, ApiConfig.dailyRequestLimit);
    } catch (e) {
      print('Error getting remaining requests: $e');
      return 0;
    }
  }
}
