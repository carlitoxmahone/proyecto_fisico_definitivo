

class UserAssessmentData {
  const UserAssessmentData({
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.waistCm,
    required this.currentGoal,
    required this.visualGoal,
    required this.trainingDays,
    required this.hasNightShift,
  });

  final String name;
  final String age;
  final String heightCm;
  final String weightKg;
  final String waistCm;
  final String currentGoal;
  final String visualGoal;
  final String trainingDays;
  final bool hasNightShift;
}

