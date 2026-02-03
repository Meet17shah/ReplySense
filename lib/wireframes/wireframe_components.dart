import 'package:flutter/material.dart';

/// WIREFRAME COMPONENTS - Reusable low-fidelity elements

class WireBox extends StatelessWidget {
  final double? width;
  final double? height;
  final String? label;
  final Color? color;

  const WireBox({
    super.key,
    this.width,
    this.height,
    this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey[100],
        border: Border.all(color: Colors.grey[400]!, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: label != null
          ? Center(
              child: Text(
                label!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }
}

class WireButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final double? width;

  const WireButton({
    super.key,
    required this.label,
    this.isPrimary = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF2563EB) : Colors.white,
        border: Border.all(
          color: isPrimary ? const Color(0xFF2563EB) : Colors.grey[400]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isPrimary ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class WireTextField extends StatelessWidget {
  final String placeholder;
  final IconData? icon;

  const WireTextField({
    super.key,
    required this.placeholder,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: Colors.grey[400]!, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            const SizedBox(width: 12),
            Icon(icon, color: Colors.grey, size: 20),
          ],
          const SizedBox(width: 12),
          Text(
            placeholder,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class WireCard extends StatelessWidget {
  final Widget child;
  final double? height;

  const WireCard({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]!, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

class WireIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final bool isCircle;

  const WireIcon({
    super.key,
    required this.icon,
    this.size = 40,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(color: Colors.grey[400]!, width: 2),
        borderRadius: isCircle ? null : BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.grey[600], size: size * 0.5),
    );
  }
}

class WireText extends StatelessWidget {
  final String text;
  final bool isHeading;
  final bool isBold;

  const WireText({
    super.key,
    required this.text,
    this.isHeading = false,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isHeading ? 20 : 14,
        fontWeight: isBold || isHeading ? FontWeight.bold : FontWeight.normal,
        color: Colors.black87,
      ),
    );
  }
}
