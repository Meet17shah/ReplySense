import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/conversation_history_model.dart';

/// Service for managing conversation history and email analysis in Firestore
class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  /// Get history collection reference for current user
  CollectionReference get _historyCollection {
    if (_currentUserId == null) {
      throw Exception('User not authenticated');
    }
    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('history');
  }

  // ==================== CREATE ====================

  /// Add new conversation history entry
  Future<String> addConversationHistory({
    required String originalEmail,
    required List<String> generatedReplies,
    required String selectedTone,
    required String summary,
    EmailAnalysisData? analysisData,
  }) async {
    try {
      final docRef = await _historyCollection.add({
        'userId': _currentUserId,
        'originalEmail': originalEmail,
        'generatedReplies': generatedReplies,
        'selectedTone': selectedTone,
        'summary': summary,
        'analysisData': analysisData?.toMap(),
        'timestamp': FieldValue.serverTimestamp(),
        'isArchived': false,
        'isFavorite': false,
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add conversation history: $e');
    }
  }

  // ==================== READ ====================

  /// Get all conversation history as stream (real-time updates)
  Stream<List<ConversationHistoryModel>> getHistoryStream({
    bool includeArchived = false,
    int limit = 50,
  }) {
    try {
      Query query = _historyCollection.orderBy('timestamp', descending: true);

      if (!includeArchived) {
        query = query.where('isArchived', isEqualTo: false);
      }

      query = query.limit(limit);

      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return ConversationHistoryModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to get history stream: $e');
    }
  }

  /// Get conversation history (one-time fetch)
  Future<List<ConversationHistoryModel>> getHistory({
    bool includeArchived = false,
    int limit = 50,
  }) async {
    try {
      Query query = _historyCollection.orderBy('timestamp', descending: true);

      if (!includeArchived) {
        query = query.where('isArchived', isEqualTo: false);
      }

      query = query.limit(limit);

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return ConversationHistoryModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get history: $e');
    }
  }

  /// Get single conversation by ID
  Future<ConversationHistoryModel?> getConversationById(
      String conversationId) async {
    try {
      final doc = await _historyCollection.doc(conversationId).get();

      if (!doc.exists) return null;

      return ConversationHistoryModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    } catch (e) {
      throw Exception('Failed to get conversation: $e');
    }
  }

  /// Get favorite conversations
  Stream<List<ConversationHistoryModel>> getFavoriteHistoryStream() {
    try {
      return _historyCollection
          .where('isFavorite', isEqualTo: true)
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return ConversationHistoryModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to get favorite history: $e');
    }
  }

  /// Get recent conversations (last N items)
  Future<List<ConversationHistoryModel>> getRecentHistory({
    int limit = 5,
  }) async {
    try {
      final snapshot = await _historyCollection
          .orderBy('timestamp', descending: true)
          .where('isArchived', isEqualTo: false)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        return ConversationHistoryModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get recent history: $e');
    }
  }

  /// Get history count
  Future<int> getHistoryCount() async {
    try {
      final snapshot = await _historyCollection
          .where('isArchived', isEqualTo: false)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get history count: $e');
    }
  }

  // ==================== UPDATE ====================

  /// Toggle favorite status
  Future<void> toggleFavorite(String conversationId, bool isFavorite) async {
    try {
      await _historyCollection.doc(conversationId).update({
        'isFavorite': isFavorite,
      });
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  /// Toggle archive status
  Future<void> toggleArchive(String conversationId, bool isArchived) async {
    try {
      await _historyCollection.doc(conversationId).update({
        'isArchived': isArchived,
      });
    } catch (e) {
      throw Exception('Failed to toggle archive: $e');
    }
  }

  // ==================== DELETE ====================

  /// Delete a conversation from history
  Future<void> deleteConversation(String conversationId) async {
    try {
      await _historyCollection.doc(conversationId).delete();
    } catch (e) {
      throw Exception('Failed to delete conversation: $e');
    }
  }

  /// Delete all archived conversations
  Future<void> deleteArchivedConversations() async {
    try {
      final snapshot =
          await _historyCollection.where('isArchived', isEqualTo: true).get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete archived conversations: $e');
    }
  }
}
