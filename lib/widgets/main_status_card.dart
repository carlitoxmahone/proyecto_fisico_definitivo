import 'package:flutter/material.dart';

import '../models/user_assessment_data.dart';

class MainStatusCard extends StatelessWidget {
  const MainStatusCard({
    required this.data,
  });

  final UserAssessmentData data;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF00E0A4),
              size: 38,
            ),
            const SizedBox(height: 14),
            const Text(
              'Plan inicial creado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Objetivo: ${data.currentGoal}. Enfoque visual: ${data.visualGoal}.',
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.76),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

