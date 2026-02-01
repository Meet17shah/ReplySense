import 'package:flutter/material.dart';
import '../config/theme.dart';

class ToneSelector extends StatelessWidget {
  final String selectedTone;
  final Function(String) onToneSelected;

  const ToneSelector({
    super.key,
    required this.selectedTone,
    required this.onToneSelected,
  });

  static const List<String> tones = [
    'Professional',
    'Casual',
    'Friendly',
    'Formal',
    'Enthusiastic',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Tone',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tones.map((tone) {
            final isSelected = tone == selectedTone;
            return GestureDetector(
              onTap: () => onToneSelected(tone),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryPurple : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryPurple
                        : const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  tone,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF424242),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
