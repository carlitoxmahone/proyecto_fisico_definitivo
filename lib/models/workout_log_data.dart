

import 'exercise_performance_log.dart';

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
    required this.performanceLogs,
  });

  final String feeling;
  final int difficulty;
  final bool hasPain;
  final String painNote;
  final bool cardioCompleted;
  final String freeNote;
  final String workoutName;
  final int replacedExercisesCount;
  final List<ExercisePerformanceLog> performanceLogs;

  int get registeredPerformanceCount {
    return performanceLogs.where((log) => log.hasData).length;
  }
}
