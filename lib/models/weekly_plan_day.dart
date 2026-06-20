import 'package:flutter/material.dart';

import 'workout_template.dart';

class WeeklyPlanDay {
  const WeeklyPlanDay({
    required this.day,
    required this.title,
    required this.type,
    required this.description,
    required this.focus,
    required this.icon,
    this.workoutTemplate,
  });

  final String day;
  final String title;
  final String type;
  final String description;
  final String focus;
  final IconData icon;
  final WorkoutTemplate? workoutTemplate;
}

