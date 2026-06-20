import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/saved_habits_summary.dart';
import '../models/saved_workout_summary.dart';

class LocalStorageService {
  static const _lastWorkoutKey = 'last_workout_summary';
  static const _workoutHistoryKey = 'workout_history';
  static const _lastHabitsKey = 'last_habits_summary';

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
  }

  static Future<SavedWorkoutSummary?> getLastWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString(_lastWorkoutKey);
    if (rawJson == null) return null;

    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) return null;

    return SavedWorkoutSummary.fromJson(decoded);
  }

  static Future<List<SavedWorkoutSummary>> getWorkoutHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString(_workoutHistoryKey);
    if (rawJson == null) return [];

    final decoded = jsonDecode(rawJson);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(SavedWorkoutSummary.fromJson)
        .toList();
  }

  static Future<void> saveLastHabits(SavedHabitsSummary summary) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastHabitsKey, jsonEncode(summary.toJson()));
  }

  static Future<SavedHabitsSummary?> getLastHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString(_lastHabitsKey);
    if (rawJson == null) return null;

    final decoded = jsonDecode(rawJson);
    if (decoded is! Map<String, dynamic>) return null;

    return SavedHabitsSummary.fromJson(decoded);
  }
}
