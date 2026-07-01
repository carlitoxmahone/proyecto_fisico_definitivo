import '../models/exercise_alternative.dart';
import '../models/exercise_library_item.dart';
import '../models/training_profile.dart';
import '../models/workout_exercise.dart';
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

  List<ExerciseAlternative> getSmartAlternativesForWorkoutExercise({
    required WorkoutExercise workoutExercise,
    required TrainingProfile profile,
  }) {
    final libraryExercise = findForWorkoutExercise(workoutExercise);
    if (libraryExercise == null) {
      return const [];
    }

    final candidates = _rankedAlternativesFor(
      libraryExercise: libraryExercise,
      profile: profile,
      expectedRole: workoutExercise.exerciseRole,
    );

    return candidates.map((candidate) {
      return ExerciseAlternative(
        name: candidate.name,
        reason: _alternativeReason(
          candidate: candidate,
          original: libraryExercise,
          profile: profile,
          expectedRole: workoutExercise.exerciseRole,
        ),
        techniqueNote: candidate.techniqueSteps.first,
      );
    }).toList(growable: false);
  }

  ExerciseLibraryItem? findForWorkoutExercise(WorkoutExercise exercise) {
    final normalizedName = _normalize(exercise.name);
    final aliasId = _workoutExerciseAliases[normalizedName];

    if (aliasId != null) {
      return findById(aliasId);
    }

    for (final item in exerciseDatabase) {
      if (_normalize(item.name) == normalizedName) {
        return item;
      }
    }

    return null;
  }

  List<ExerciseLibraryItem> _rankedAlternativesFor({
    required ExerciseLibraryItem libraryExercise,
    required TrainingProfile profile,
    required String expectedRole,
  }) {
    final perfect = _rankedCandidates(
      libraryExercise: libraryExercise,
      profile: profile,
      expectedRole: expectedRole,
      requireSameMuscle: true,
      requireSameMovement: true,
      requireSameRole: true,
      requireGoal: true,
      requireLevel: true,
    );
    if (perfect.isNotEmpty) {
      return perfect;
    }

    final sameMuscle = _rankedCandidates(
      libraryExercise: libraryExercise,
      profile: profile,
      expectedRole: expectedRole,
      requireSameMuscle: true,
    );
    if (sameMuscle.isNotEmpty) {
      return sameMuscle;
    }

    return _rankedCandidates(
      libraryExercise: libraryExercise,
      profile: profile,
      expectedRole: expectedRole,
      requireGoal: true,
    );
  }

  List<ExerciseLibraryItem> _rankedCandidates({
    required ExerciseLibraryItem libraryExercise,
    required TrainingProfile profile,
    required String expectedRole,
    bool requireSameMuscle = false,
    bool requireSameMovement = false,
    bool requireSameRole = false,
    bool requireGoal = false,
    bool requireLevel = false,
  }) {
    final candidates = exerciseDatabase.where((candidate) {
      if (candidate.id == libraryExercise.id) return false;
      if (requireSameMuscle &&
          candidate.primaryMuscle != libraryExercise.primaryMuscle) {
        return false;
      }
      if (requireSameMovement &&
          candidate.movementPattern != libraryExercise.movementPattern) {
        return false;
      }
      if (requireSameRole && candidate.recommendedRole != expectedRole) {
        return false;
      }
      if (requireGoal && !_isCompatibleWithGoal(candidate, profile.goal)) {
        return false;
      }
      if (requireLevel && !_isLevelSuitable(candidate, profile.level)) {
        return false;
      }

      return true;
    }).toList();

    candidates.sort((a, b) {
      final scoreA = _candidateScore(
        a,
        libraryExercise,
        profile,
        expectedRole,
      );
      final scoreB = _candidateScore(
        b,
        libraryExercise,
        profile,
        expectedRole,
      );

      if (scoreA != scoreB) {
        return scoreB.compareTo(scoreA);
      }

      return a.name.compareTo(b.name);
    });

    return candidates.take(5).toList(growable: false);
  }

  int _candidateScore(
    ExerciseLibraryItem candidate,
    ExerciseLibraryItem original,
    TrainingProfile profile,
    String expectedRole,
  ) {
    var score = 0;

    if (candidate.primaryMuscle == original.primaryMuscle) score += 8;
    if (candidate.movementPattern == original.movementPattern) score += 5;
    if (candidate.recommendedRole == expectedRole) score += 4;
    if (_isCompatibleWithGoal(candidate, profile.goal)) score += 4;
    if (_isLevelSuitable(candidate, profile.level)) score += 3;
    if (candidate.equipment == original.equipment) score += 2;
    if (original.alternatives.contains(candidate.id)) score += 2;

    return score;
  }

  bool _isCompatibleWithGoal(ExerciseLibraryItem exercise, String goal) {
    final normalizedGoal = _normalize(goal);

    return exercise.compatibleGoals.any(
      (exerciseGoal) => _normalize(exerciseGoal) == normalizedGoal,
    );
  }

  bool _isLevelSuitable(ExerciseLibraryItem exercise, String level) {
    final normalizedLevel = _normalize(level);

    if (normalizedLevel == 'principiante') {
      return _normalize(exercise.level) == 'principiante';
    }

    return true;
  }

  String _alternativeReason({
    required ExerciseLibraryItem candidate,
    required ExerciseLibraryItem original,
    required TrainingProfile profile,
    required String expectedRole,
  }) {
    final reasons = <String>[];

    if (candidate.primaryMuscle == original.primaryMuscle) {
      reasons.add('mismo grupo muscular');
    }
    if (candidate.movementPattern == original.movementPattern) {
      reasons.add('patrón similar');
    }
    if (candidate.recommendedRole == expectedRole) {
      reasons.add('mismo rol');
    }
    if (_isCompatibleWithGoal(candidate, profile.goal)) {
      reasons.add('compatible con ${profile.goal}');
    }
    if (candidate.equipment == original.equipment) {
      reasons.add('equipamiento parecido');
    }

    if (reasons.isEmpty) {
      return 'Alternativa compatible desde la biblioteca de ejercicios.';
    }

    return 'Biblioteca: ${reasons.join(', ')}.';
  }

  String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ñ', 'n');
  }

  static const Map<String, String> _workoutExerciseAliases = {
    'press de pecho en maquina': 'press_pecho_maquina',
    'press de pecho convergente o maquina': 'press_pecho_maquina',
    'press inclinado en maquina': 'press_inclinado_mancuernas',
    'press con mancuernas ligero': 'press_inclinado_mancuernas',
    'press de pecho convergente': 'press_pecho_maquina',
    'jalon agarre comodo': 'jalon_agarre_neutro',
    'jalon con agarre comodo': 'jalon_agarre_neutro',
    'jalon cerrado': 'jalon_agarre_neutro',
    'remo en maquina con pecho apoyado': 'remo_maquina',
    'remo con mancuerna apoyado': 'remo_mancuerna',
    'sentadilla goblet o multipower suave': 'sentadilla_goblet',
    'sentadilla goblet suave': 'sentadilla_goblet',
    'sentadilla en multipower suave': 'sentadilla_multipower',
    'goblet squat con mancuerna': 'sentadilla_goblet',
    'prensa de piernas ligera': 'prensa_piernas',
    'curl femoral sentado o tumbado': 'curl_femoral_sentado',
    'peso muerto rumano con mancuernas ligero': 'peso_muerto_rumano',
    'hip thrust en maquina': 'hip_thrust',
    'puente de gluteo': 'hip_thrust',
    'face pull en polea': 'face_pull',
    'face pull suave': 'face_pull',
    'pajaros en maquina': 'pajaros_mancuernas',
    'elevaciones laterales suaves': 'elevaciones_laterales',
    'maquina de hombro lateral': 'elevaciones_laterales',
    'curl biceps en polea o maquina': 'curl_biceps_barra_z',
    'press triceps en polea': 'triceps_polea_barra',
    'extension triceps con cuerda': 'triceps_polea_cuerda',
    'extension triceps por encima de la cabeza en polea':
        'press_frances_mancuernas',
    'fondos asistidos en maquina': 'fondos_asistidos',
    'plancha abdominal': 'plancha',
    'dead bug': 'plancha',
    'crunch en maquina suave': 'crunch_maquina',
  };
}
