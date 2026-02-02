import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/template_model.dart';

/// Service class for managing CRUD operations on Template data
/// Handles all Firebase Firestore interactions for templates
class TemplateService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  /// Get templates collection reference for current user
  CollectionReference get _templatesCollection {
    if (_currentUserId == null) {
      throw Exception('User not authenticated');
    }
    return _firestore
        .collection('users')
        .doc(_currentUserId)
        .collection('templates');
  }

  // ==================== CREATE ====================

  /// Add a new template to Firestore
  /// Returns the created template ID on success
  Future<String> addTemplate({
    required String title,
    required String content,
    required String category,
  }) async {
    try {
      // Validate inputs
      final titleError = TemplateModel.validateTitle(title);
      if (titleError != null) throw Exception(titleError);

      final contentError = TemplateModel.validateContent(content);
      if (contentError != null) throw Exception(contentError);

      final categoryError = TemplateModel.validateCategory(category);
      if (categoryError != null) throw Exception(categoryError);

      // Create template document
      final docRef = await _templatesCollection.add({
        'title': title.trim(),
        'content': content.trim(),
        'category': category,
        'createdAt': FieldValue.serverTimestamp(),
        'userId': _currentUserId,
        'usageCount': 0,
        'isFavorite': false,
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add template: $e');
    }
  }

  // ==================== READ ====================

  /// Get all templates for current user as a stream (real-time updates)
  Stream<List<TemplateModel>> getTemplatesStream() {
    try {
      return _templatesCollection
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return TemplateModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to get templates stream: $e');
    }
  }

  /// Get all templates for current user (one-time fetch)
  Future<List<TemplateModel>> getTemplates() async {
    try {
      final snapshot = await _templatesCollection
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return TemplateModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get templates: $e');
    }
  }

  /// Get a single template by ID
  Future<TemplateModel?> getTemplateById(String templateId) async {
    try {
      final doc = await _templatesCollection.doc(templateId).get();

      if (!doc.exists) {
        return null;
      }

      return TemplateModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    } catch (e) {
      throw Exception('Failed to get template: $e');
    }
  }

  /// Get templates by category
  Stream<List<TemplateModel>> getTemplatesByCategory(String category) {
    try {
      return _templatesCollection
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return TemplateModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to get templates by category: $e');
    }
  }

  /// Get favorite templates
  Stream<List<TemplateModel>> getFavoriteTemplates() {
    try {
      return _templatesCollection
          .where('isFavorite', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return TemplateModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to get favorite templates: $e');
    }
  }

  /// Get template count for current user
  Future<int> getTemplateCount() async {
    try {
      final snapshot = await _templatesCollection.get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get template count: $e');
    }
  }

  /// Get template count stream (real-time)
  Stream<int> getTemplateCountStream() {
    try {
      return _templatesCollection.snapshots().map((snapshot) {
        return snapshot.docs.length;
      });
    } catch (e) {
      throw Exception('Failed to get template count stream: $e');
    }
  }

  // ==================== UPDATE ====================

  /// Update an existing template
  Future<void> updateTemplate({
    required String templateId,
    String? title,
    String? content,
    String? category,
    bool? isFavorite,
  }) async {
    try {
      final Map<String, dynamic> updates = {};

      if (title != null) {
        final titleError = TemplateModel.validateTitle(title);
        if (titleError != null) throw Exception(titleError);
        updates['title'] = title.trim();
      }

      if (content != null) {
        final contentError = TemplateModel.validateContent(content);
        if (contentError != null) throw Exception(contentError);
        updates['content'] = content.trim();
      }

      if (category != null) {
        final categoryError = TemplateModel.validateCategory(category);
        if (categoryError != null) throw Exception(categoryError);
        updates['category'] = category;
      }

      if (isFavorite != null) {
        updates['isFavorite'] = isFavorite;
      }

      if (updates.isEmpty) {
        throw Exception('No fields to update');
      }

      await _templatesCollection.doc(templateId).update(updates);
    } catch (e) {
      throw Exception('Failed to update template: $e');
    }
  }

  /// Increment usage count when template is used
  Future<void> incrementUsageCount(String templateId) async {
    try {
      await _templatesCollection.doc(templateId).update({
        'usageCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment usage count: $e');
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String templateId, bool currentStatus) async {
    try {
      await _templatesCollection.doc(templateId).update({
        'isFavorite': !currentStatus,
      });
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  // ==================== DELETE ====================

  /// Delete a template
  Future<void> deleteTemplate(String templateId) async {
    try {
      await _templatesCollection.doc(templateId).delete();
    } catch (e) {
      throw Exception('Failed to delete template: $e');
    }
  }

  /// Delete all templates for current user
  Future<void> deleteAllTemplates() async {
    try {
      final snapshot = await _templatesCollection.get();
      final batch = _firestore.batch();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete all templates: $e');
    }
  }

  /// Delete templates by category
  Future<void> deleteTemplatesByCategory(String category) async {
    try {
      final snapshot = await _templatesCollection
          .where('category', isEqualTo: category)
          .get();

      final batch = _firestore.batch();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete templates by category: $e');
    }
  }

  // ==================== SEARCH ====================

  /// Search templates by title or content
  Future<List<TemplateModel>> searchTemplates(String query) async {
    try {
      final allTemplates = await getTemplates();

      if (query.trim().isEmpty) {
        return allTemplates;
      }

      final searchQuery = query.toLowerCase().trim();

      return allTemplates.where((template) {
        final titleMatch = template.title.toLowerCase().contains(searchQuery);
        final contentMatch =
            template.content.toLowerCase().contains(searchQuery);
        final categoryMatch =
            template.category.toLowerCase().contains(searchQuery);

        return titleMatch || contentMatch || categoryMatch;
      }).toList();
    } catch (e) {
      throw Exception('Failed to search templates: $e');
    }
  }
}
