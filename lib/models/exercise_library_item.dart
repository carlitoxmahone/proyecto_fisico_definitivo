class ExerciseLibraryItem {
  const ExerciseLibraryItem({
    required this.id,
    required this.name,
    required this.primaryMuscle,
    required this.secondaryMuscles,
    required this.movementPattern,
    required this.equipment,
    required this.level,
    required this.recommendedRole,
    required this.compatibleGoals,
    required this.alternatives,
    required this.techniqueSteps,
    required this.commonMistakes,
    required this.safetyNote,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String primaryMuscle;
  final List<String> secondaryMuscles;
  final String movementPattern;
  final String equipment;
  final String level;
  final String recommendedRole;
  final List<String> compatibleGoals;
  final List<String> alternatives;
  final List<String> techniqueSteps;
  final List<String> commonMistakes;
  final String safetyNote;
  final String imageAsset;
}
