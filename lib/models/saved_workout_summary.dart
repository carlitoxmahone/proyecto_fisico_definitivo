class SavedWorkoutSummary {
  const SavedWorkoutSummary({
    required this.workoutName,
    required this.feeling,
    required this.difficulty,
    required this.cardioCompleted,
    required this.replacedExercisesCount,
    required this.registeredPerformanceCount,
    required this.hasPain,
    required this.savedAtText,
    this.savedAtIso,
    this.workoutType = 'guiado',
    this.registeredExerciseCount = 0,
    this.registeredSetCount = 0,
  });

  final String workoutName;
  final String feeling;
  final int difficulty;
  final bool cardioCompleted;
  final int replacedExercisesCount;
  final int registeredPerformanceCount;
  final bool hasPain;
  final String savedAtText;
  final String? savedAtIso;
  final String workoutType;
  final int registeredExerciseCount;
  final int registeredSetCount;

  bool get isFreeWorkout => workoutType == 'libre';

  Map<String, dynamic> toJson() {
    return {
      'workoutName': workoutName,
      'feeling': feeling,
      'difficulty': difficulty,
      'cardioCompleted': cardioCompleted,
      'replacedExercisesCount': replacedExercisesCount,
      'registeredPerformanceCount': registeredPerformanceCount,
      'hasPain': hasPain,
      'savedAtText': savedAtText,
      'savedAtIso': savedAtIso,
      'workoutType': workoutType,
      'registeredExerciseCount': registeredExerciseCount,
      'registeredSetCount': registeredSetCount,
    };
  }

  factory SavedWorkoutSummary.fromJson(Map<String, dynamic> json) {
    return SavedWorkoutSummary(
      workoutName: json['workoutName'] as String? ?? '',
      feeling: json['feeling'] as String? ?? '',
      difficulty: json['difficulty'] as int? ?? 0,
      cardioCompleted: json['cardioCompleted'] as bool? ?? false,
      replacedExercisesCount: json['replacedExercisesCount'] as int? ?? 0,
      registeredPerformanceCount:
          json['registeredPerformanceCount'] as int? ?? 0,
      hasPain: json['hasPain'] as bool? ?? false,
      savedAtText: json['savedAtText'] as String? ?? '',
      savedAtIso: json['savedAtIso'] as String?,
      workoutType: json['workoutType'] as String? ?? 'guiado',
      registeredExerciseCount: json['registeredExerciseCount'] as int? ?? 0,
      registeredSetCount: json['registeredSetCount'] as int? ?? 0,
    );
  }
}
