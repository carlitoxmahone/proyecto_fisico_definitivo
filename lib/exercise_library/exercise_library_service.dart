import '../models/exercise_library_item.dart';
import 'exercise_database.dart';

class ExerciseLibraryService {
  const ExerciseLibraryService();

  List<ExerciseLibraryItem> getAllExercises() {
    return List.unmodifiable(exerciseDatabase);
  }

  ExerciseLibraryItem? findById(String id) {
    for (final exercise in exerciseDatabase) {
      if (exercise.id == id) {
        return exercise;
      }
    }

    return null;
  }

  List<ExerciseLibraryItem> getExercisesByMuscle(String muscle) {
    final normalizedMuscle = _normalize(muscle);

    return exerciseDatabase.where((exercise) {
      return _normalize(exercise.primaryMuscle) == normalizedMuscle ||
          exercise.secondaryMuscles
              .any((secondary) => _normalize(secondary) == normalizedMuscle);
    }).toList(growable: false);
  }

  List<ExerciseLibraryItem> getExercisesByGoal(String goal) {
    final normalizedGoal = _normalize(goal);

    return exerciseDatabase.where((exercise) {
      return exercise.compatibleGoals
          .any((exerciseGoal) => _normalize(exerciseGoal) == normalizedGoal);
    }).toList(growable: false);
  }

  List<ExerciseLibraryItem> getExercisesByEquipment(String equipment) {
    final normalizedEquipment = _normalize(equipment);

    return exerciseDatabase.where((exercise) {
      return _normalize(exercise.equipment) == normalizedEquipment;
    }).toList(growable: false);
  }

  List<ExerciseLibraryItem> getAlternativesFor(String exerciseId) {
    final exercise = findById(exerciseId);
    if (exercise == null) {
      return const [];
    }

    return exercise.alternatives
        .map(findById)
        .whereType<ExerciseLibraryItem>()
        .toList(growable: false);
  }

  String _normalize(String value) {
    return value.trim().toLowerCase();
  }
}
