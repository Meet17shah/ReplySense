import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/template_model.dart';
import '../../services/template_service.dart';
import '../../config/theme.dart';
import 'edit_template_screen.dart';

/// Template Detail Screen - Displays full template with actions
/// Allows viewing, copying, editing, and deleting templates
class TemplateDetailScreen extends StatefulWidget {
  final TemplateModel template;

  const TemplateDetailScreen({
    super.key,
    required this.template,
  });

  @override
  State<TemplateDetailScreen> createState() => _TemplateDetailScreenState();
}

class _TemplateDetailScreenState extends State<TemplateDetailScreen> {
  final TemplateService _templateService = TemplateService();
  late TemplateModel _template;

  @override
  void initState() {
    super.initState();
    _template = widget.template;
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _template.content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Template copied to clipboard!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Increment usage count
    _templateService.incrementUsageCount(_template.id);
  }

  void _toggleFavorite() {
    _templateService.toggleFavorite(_template.id, _template.isFavorite);
    setState(() {
      _template = _template.copyWith(isFavorite: !_template.isFavorite);
    });
  }

  Future<void> _editTemplate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTemplateScreen(template: _template),
      ),
    );

    if (result != null && mounted) {
      // Refresh template data
      final updatedTemplate =
          await _templateService.getTemplateById(_template.id);
      if (updatedTemplate != null && mounted) {
        setState(() {
          _template = updatedTemplate;
        });
      }
    }
  }

  Future<void> _deleteTemplate() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Template'),
        content: Text(
          'Are you sure you want to delete "${_template.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _templateService.deleteTemplate(_template.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Template deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Go back to list screen
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Professional':
        return Colors.blue;
      case 'Casual':
        return Colors.green;
      case 'Apology':
        return Colors.red;
      case 'Thank You':
        return Colors.purple;
      case 'Follow Up':
        return Colors.orange;
      case 'Meeting':
        return Colors.teal;
      case 'Introduction':
        return Colors.indigo;
      case 'Rejection':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Details'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _template.isFavorite ? Icons.star : Icons.star_border,
              color: _template.isFavorite ? Colors.amber : Colors.white,
            ),
            tooltip: 'Toggle Favorite',
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Template',
            onPressed: _editTemplate,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete Template',
            onPressed: _deleteTemplate,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section with Category
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _getCategoryColor(_template.category).withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: _getCategoryColor(_template.category),
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(_template.category),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _template.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    _template.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Created Date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Created on ${_formatDate(_template.createdAt)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Times Used',
                      '${_template.usageCount}',
                      Icons.analytics_outlined,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Characters',
                      '${_template.content.length}',
                      Icons.text_fields,
                      Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Template Content',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SelectableText(
                        _template.content,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Action Buttons Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Copy Button
                  ElevatedButton.icon(
                    onPressed: _copyToClipboard,
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Template'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Edit Button
                  OutlinedButton.icon(
                    onPressed: _editTemplate,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Template'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Delete Button
                  OutlinedButton.icon(
                    onPressed: _deleteTemplate,
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Delete Template',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
