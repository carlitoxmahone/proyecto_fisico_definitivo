import 'package:flutter/material.dart';

import '../models/nutrition_meal.dart';
import 'small_chip.dart';

class NutritionMealCard extends StatelessWidget {
  const NutritionMealCard({
    required this.number,
    required this.meal,
  });

  final int number;
  final NutritionMeal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor:
                  const Color(0xFF00E0A4).withValues(alpha: 0.16),
              foregroundColor: const Color(0xFF00E0A4),
              child: Text(
                '$number',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.time,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meal.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.description,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.38,
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SmallChip(label: meal.goal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

