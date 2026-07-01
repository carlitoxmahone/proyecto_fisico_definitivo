class TrainingProfile {
  const TrainingProfile({
    required this.goal,
    required this.level,
    required this.priority,
  });

  static const goals = [
    'Adaptación',
    'Hipertrofia',
    'Fuerza',
    'Recomposición',
  ];

  static const levels = [
    'Principiante',
    'Intermedio',
    'Avanzado',
  ];

  static const priorities = [
    'Ganar músculo',
    'Ganar fuerza',
    'Perder grasa',
    'Mejorar forma física',
    'Reducir fatiga',
  ];

  static const defaultProfile = TrainingProfile(
    goal: 'Recomposición',
    level: 'Principiante',
    priority: 'Ganar músculo',
  );

  final String goal;
  final String level;
  final String priority;

  String get explanation {
    return 'Futuras automatizaciones dependerán del perfil, objetivo actual, nivel, datos registrados, dolor, fatiga y adherencia.';
  }

  Map<String, dynamic> toJson() {
    return {
      'goal': goal,
      'level': level,
      'priority': priority,
    };
  }

  factory TrainingProfile.fromJson(Map<String, dynamic> json) {
    final goal = json['goal'] as String? ?? defaultProfile.goal;
    final level = json['level'] as String? ?? defaultProfile.level;
    final priority = json['priority'] as String? ?? defaultProfile.priority;

    return TrainingProfile(
      goal: goals.contains(goal) ? goal : defaultProfile.goal,
      level: levels.contains(level) ? level : defaultProfile.level,
      priority:
          priorities.contains(priority) ? priority : defaultProfile.priority,
    );
  }
}
