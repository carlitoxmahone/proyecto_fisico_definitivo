import 'package:flutter/material.dart';

import '../models/weekly_plan_day.dart';
import 'small_chip.dart';

class WeeklyPlanDayCard extends StatelessWidget {
  const WeeklyPlanDayCard({
    required this.day,
    this.onTap,
  });

  final WeeklyPlanDay day;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isWorkout = day.workoutTemplate != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isWorkout
              ? const Color(0xFF00E0A4).withValues(alpha: 0.20)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor:
                    const Color(0xFF00E0A4).withValues(alpha: 0.16),
                foregroundColor: const Color(0xFF00E0A4),
                child: Icon(day.icon, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${day.day} · ${day.type}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.55),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      day.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      day.description,
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.38,
                        color: Colors.white.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SmallChip(label: day.focus),
                        if (isWorkout)
                          const SmallChip(label: 'Tocar para abrir'),
                      ],
                    ),
                  ],
                ),
              ),
              if (isWorkout)
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF00E0A4),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

