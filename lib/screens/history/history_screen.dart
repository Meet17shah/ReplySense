import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../widgets/history_card.dart';
import '../replies/result_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Dummy history data
  final List<Map<String, dynamic>> _historyItems = [
    {
      'summary':
          'Collaboration proposal for Q1 project with timeline and budget details.',
      'tone': 'Professional',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'emailText':
          'Dear Team, I would like to propose a new collaboration for Q1...',
    },
    {
      'summary':
          'Meeting request for product demo scheduled for next week.',
      'tone': 'Friendly',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'emailText':
          'Hi there, I hope this email finds you well. I wanted to reach out...',
    },
    {
      'summary':
          'Invoice payment confirmation and receipt for services rendered.',
      'tone': 'Formal',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      'emailText':
          'To whom it may concern, This is to confirm receipt of payment...',
    },
    {
      'summary':
          'Feedback request for recent presentation and suggestions for improvement.',
      'tone': 'Casual',
      'timestamp': DateTime.now().subtract(const Duration(days: 5)),
      'emailText':
          'Hey! I just wanted to check in and see what you thought about...',
    },
    {
      'summary':
          'Partnership opportunity discussion with potential expansion plans.',
      'tone': 'Enthusiastic',
      'timestamp': DateTime.now().subtract(const Duration(days: 7)),
      'emailText':
          'Great news! We have an exciting opportunity that I think...',
    },
  ];

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _historyItems.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item deleted'),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _viewDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          emailText: item['emailText'],
          tone: item['tone'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_historyItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear All',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: const Text('Clear All History'),
                    content: const Text(
                      'Are you sure you want to delete all history items?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _historyItems.clear();
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                        ),
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: Container(
        color: const Color(0xFFF5F5F5),
        child: _historyItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.history,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No History Yet',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your generated replies will\nappear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: AppGradients.blueGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_historyItems.length} Items',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ..._historyItems.asMap().entries.map(
                        (entry) => HistoryCard(
                          summary: entry.value['summary'],
                          tone: entry.value['tone'],
                          timestamp: entry.value['timestamp'],
                          onTap: () => _viewDetails(entry.value),
                          onDelete: () => _deleteItem(entry.key),
                        ),
                      ),
                ],
              ),
      ),
    );
  }
}
