class SavedHabitsSummary {
  const SavedHabitsSummary({
    required this.waterGlasses,
    required this.steps,
    required this.energy,
    required this.snackAnxiety,
    required this.savedAtText,
  });

  final int waterGlasses;
  final int steps;
  final int energy;
  final int snackAnxiety;
  final String savedAtText;

  Map<String, dynamic> toJson() {
    return {
      'waterGlasses': waterGlasses,
      'steps': steps,
      'energy': energy,
      'snackAnxiety': snackAnxiety,
      'savedAtText': savedAtText,
    };
  }

  factory SavedHabitsSummary.fromJson(Map<String, dynamic> json) {
    return SavedHabitsSummary(
      waterGlasses: json['waterGlasses'] as int? ?? 0,
      steps: json['steps'] as int? ?? 0,
      energy: json['energy'] as int? ?? 0,
      snackAnxiety: json['snackAnxiety'] as int? ?? 0,
      savedAtText: json['savedAtText'] as String? ?? '',
    );
  }
}
