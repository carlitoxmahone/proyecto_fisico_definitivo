import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/saved_habits_summary.dart';
import '../models/saved_workout_summary.dart';
import '../models/training_profile.dart';

class LocalStorageService {
  static const _lastWorkoutKey = 'last_workout_summary';
  static const _workoutHistoryKey = 'workout_history';
  static const _lastHabitsKey = 'last_habits_summary';
  static const _habitsHistoryKey = 'habits_history';
  static const _trainingProfileKey = 'training_profile';

  static Future<void> saveTrainingProfile(TrainingProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_trainingProfileKey, jsonEncode(profile.toJson()));
  }

  static Future<TrainingProfile> getTrainingProfile() async {
    return await getSavedTrainingProfile() ?? TrainingProfile.defaultProfile;
  }

  static Future<TrainingProfile?> getSavedTrainingProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final rawJson = prefs.getString(_trainingProfileKey);
    if (rawJson == null) return null;

    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) return null;

    return TrainingProfile.fromJson(decoded);
  }

  static Future<void> saveLastWorkout(SavedWorkoutSummary summary) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastWorkoutKey, jsonEncode(summary.toJson()));
  }

  static Future<void> saveWorkoutToHistory(
    SavedWorkoutSummary summary,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getWorkoutHistory();
    final updatedHistory = [summary, ...history].take(20).toList();

    await prefs.setString(
      _workoutHistoryKey,
      jsonEncode(
        updatedHistory.map((item) => item.toJson()).toList(),
      ),
    );
    debugPrint(
      'Historial entrenamientos guardado: ${updatedHistory.length}',
    );
  }

  static Future<SavedWorkoutSummary?> getLastWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final rawJson = prefs.getString(_lastWorkoutKey);
    if (rawJson == null) return null;

    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) return null;

    return SavedWorkoutSummary.fromJson(decoded);
  }

  static Future<List<SavedWorkoutSummary>> getWorkoutHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final rawJson = prefs.getString(_workoutHistoryKey);
    if (rawJson == null) {
      debugPrint('Historial entrenamientos leído: 0');
      return [];
    }

    final decoded = jsonDecode(rawJson);
    if (decoded is! List) {
      debugPrint('Historial entrenamientos leído: 0');
      return [];
    }

    final history = decoded
        .whereType<Map<String, dynamic>>()
        .map(SavedWorkoutSummary.fromJson)
        .toList();
    debugPrint('Historial entrenamientos leído: ${history.length}');
    return history;
  }

  static Future<void> saveLastHabits(SavedHabitsSummary summary) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastHabitsKey, jsonEncode(summary.toJson()));
  }

  static Future<void> saveHabitsToHistory(SavedHabitsSummary summary) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHabitsHistory();
    final updatedHistory = [summary, ...history].take(30).toList();

    await prefs.setString(
      _habitsHistoryKey,
      jsonEncode(
        updatedHistory.map((item) => item.toJson()).toList(),
      ),
    );
    debugPrint('Historial hábitos guardado: ${updatedHistory.length}');
  }

  static Future<SavedHabitsSummary?> getLastHabits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final rawJson = prefs.getString(_lastHabitsKey);
    if (rawJson == null) return null;

    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) return null;

    return SavedHabitsSummary.fromJson(decoded);
  }

  static Future<List<SavedHabitsSummary>> getHabitsHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final rawJson = prefs.getString(_habitsHistoryKey);
    if (rawJson == null) {
      debugPrint('Historial hábitos leído: 0');
      return [];
    }

    final decoded = jsonDecode(rawJson);
    if (decoded is! List) {
      debugPrint('Historial hábitos leído: 0');
      return [];
    }

    final history = decoded
        .whereType<Map<String, dynamic>>()
        .map(SavedHabitsSummary.fromJson)
        .toList();
    debugPrint('Historial hábitos leído: ${history.length}');
    return history;
  }
}
