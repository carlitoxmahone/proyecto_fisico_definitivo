import 'exercise_alternative.dart';

class WorkoutExercise {
  const WorkoutExercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.techniqueNote,
    this.exerciseRole = 'accesorio',
    this.alternatives = const [],
    this.wasReplaced = false,
    this.originalName,
  });

  final String name;
  final String sets;
  final String reps;
  final String rest;
  final String techniqueNote;
  final String exerciseRole;
  final List<ExerciseAlternative> alternatives;
  final bool wasReplaced;
  final String? originalName;

  WorkoutExercise replacedBy(ExerciseAlternative alternative) {
    return WorkoutExercise(
      name: alternative.name,
      sets: sets,
      reps: reps,
      rest: rest,
      techniqueNote: alternative.techniqueNote,
      exerciseRole: exerciseRole,
      alternatives: alternatives,
      wasReplaced: true,
      originalName: originalName ?? name,
    );
  }
}
