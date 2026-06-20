import 'exercise_set_log.dart';

class ExercisePerformanceLog {
  const ExercisePerformanceLog({
    required this.exerciseName,
    required this.sets,
  });

  final String exerciseName;
  final List<ExerciseSetLog> sets;

  bool get hasData => sets.any((set) => set.hasData);
}
