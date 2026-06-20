import 'package:flutter/material.dart';

class NutritionModeCard extends StatelessWidget {
  const NutritionModeCard({
    required this.trainingDay,
    required this.onChanged,
  });

  final bool trainingDay;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF101F1B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: const Color(0xFF00E0A4).withValues(alpha: 0.28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tipo de día',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  label: Text('Entreno'),
                  icon: Icon(Icons.fitness_center_outlined),
                ),
                ButtonSegment(
                  value: false,
                  label: Text('Descanso'),
                  icon: Icon(Icons.bedtime_outlined),
                ),
              ],
              selected: {trainingDay},
              onSelectionChanged: (selection) {
                onChanged(selection.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}

