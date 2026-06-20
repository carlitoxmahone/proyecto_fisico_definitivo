import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({
    required this.title,
    required this.value,
    required this.label,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
  });

  final String title;
  final double value;
  final String label;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final int divisions;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title: $label',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            Slider(
              min: min,
              max: max,
              divisions: divisions,
              value: value,
              label: label,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

