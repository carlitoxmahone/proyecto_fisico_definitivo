

class WorkoutLogData {
  const WorkoutLogData({
    required this.feeling,
    required this.difficulty,
    required this.hasPain,
    required this.painNote,
    required this.cardioCompleted,
    required this.freeNote,
    required this.workoutName,
    required this.replacedExercisesCount,
  });

  final String feeling;
  final int difficulty;
  final bool hasPain;
  final String painNote;
  final bool cardioCompleted;
  final String freeNote;
  final String workoutName;
  final int replacedExercisesCount;
}

