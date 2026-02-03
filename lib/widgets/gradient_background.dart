import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool useFullGradient;

  const GradientBackground({
    super.key,
    required this.child,
    this.useFullGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC), // Clean light gray background
      ),
      child: child,
    );
  }
}
