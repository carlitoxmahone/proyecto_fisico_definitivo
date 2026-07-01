import '../models/training_profile.dart';
import 'training_goal_rules.dart';

class TrainingKnowledgeService {
  const TrainingKnowledgeService._();

  static TrainingGoalRule ruleForProfile(TrainingProfile profile) {
    return getRuleForProfile(profile);
  }

  static TrainingGoalRule getRuleForProfile(TrainingProfile profile) {
    return ruleFor(
      goal: profile.goal,
      level: profile.level,
    );
  }

  static TrainingGoalRule ruleFor({
    required String goal,
    required String level,
  }) {
    final exactRule = trainingGoalRules.where(
      (rule) => rule.goal == goal && rule.level == level,
    );
    if (exactRule.isNotEmpty) return exactRule.first;

    final beginnerRule = trainingGoalRules.where(
      (rule) => rule.goal == goal && rule.level == 'Principiante',
    );
    if (beginnerRule.isNotEmpty) return beginnerRule.first;

    return trainingGoalRules.firstWhere(
      (rule) =>
          rule.goal == TrainingProfile.defaultProfile.goal &&
          rule.level == TrainingProfile.defaultProfile.level,
    );
  }
}
