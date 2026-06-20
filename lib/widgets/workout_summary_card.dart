import 'package:flutter/material.dart';

import 'summary_pill.dart';

class WorkoutSummaryCard extends StatelessWidget {
  const WorkoutSummaryCard({
    required this.goal,
    required this.schedule,
    required this.workoutName,
  });

  final String goal;
  final String schedule;
  final String workoutName;

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
        padding: const EdgeInsets.all(22),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SummaryPill(
              icon: Icons.flag_outlined,
              label: 'Objetivo',
              value: goal,
            ),
            SummaryPill(
              icon: Icons.schedule_outlined,
              label: 'Horario',
              value: schedule,
            ),
            SummaryPill(
              icon: Icons.assignment_outlined,
              label: 'Sesión',
              value: workoutName,
            ),
            const SummaryPill(
              icon: Icons.speed_outlined,
              label: 'Intensidad',
              value: 'Moderada',
            ),
          ],
        ),
      ),
    );
  }
}

