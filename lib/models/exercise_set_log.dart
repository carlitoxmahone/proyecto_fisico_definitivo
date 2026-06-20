class ExerciseSetLog {
  const ExerciseSetLog({
    required this.kg,
    required this.reps,
  });

  final String kg;
  final String reps;

  bool get hasData => kg.trim().isNotEmpty || reps.trim().isNotEmpty;
}
