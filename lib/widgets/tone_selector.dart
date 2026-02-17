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

  // Tone values (lowercase for API)
  static const List<Map<String, String>> tones = [
    {'value': 'professional', 'label': 'Professional'},
    {'value': 'friendly', 'label': 'Friendly'},
    {'value': 'formal', 'label': 'Formal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Select Tone',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tones.map((tone) {
            final isSelected = tone['value'] == selectedTone;
            return GestureDetector(
              onTap: () => onToneSelected(tone['value']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  tone['label']!,
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
