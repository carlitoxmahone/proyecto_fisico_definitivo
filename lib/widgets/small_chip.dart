import 'package:flutter/material.dart';

class SmallChip extends StatelessWidget {
  const SmallChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFF00E0A4).withValues(alpha: 0.10),
      side: BorderSide(
        color: const Color(0xFF00E0A4).withValues(alpha: 0.16),
      ),
    );
  }
}

