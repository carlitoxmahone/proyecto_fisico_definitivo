import 'workout_exercise.dart';

class WorkoutTemplate {
  const WorkoutTemplate({
    required this.name,
    required this.subtitle,
    required this.focus,
    required this.exercises,
  });

  final String name;
  final String subtitle;
  final String focus;
  final List<WorkoutExercise> exercises;
}

