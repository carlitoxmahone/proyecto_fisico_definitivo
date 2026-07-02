import 'package:flutter/material.dart';

import '../models/saved_workout_summary.dart';
import '../services/local_storage_service.dart';
import '../widgets/section_title.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  late final Future<List<SavedWorkoutSummary>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = LocalStorageService.getWorkoutHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de entrenamientos')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: FutureBuilder<List<SavedWorkoutSummary>>(
              future: _historyFuture,
              builder: (context, snapshot) {
                final history = snapshot.data ?? [];

                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const SectionTitle(
                      icon: Icons.history,
                      title: 'Historial de entrenamientos',
                    ),
                    const SizedBox(height: 12),
                    if (history.isEmpty)
                      Card(
                        color: const Color(0xFF121821),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            'Aún no hay entrenamientos guardados. Completa uno para verlo aquí.',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                              color: Colors.white.withValues(alpha: 0.72),
                            ),
                          ),
                        ),
                      )
                    else
                      ...history.map(
                        (item) => _WorkoutHistoryCard(summary: item),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WorkoutHistoryCard extends StatelessWidget {
  const _WorkoutHistoryCard({required this.summary});

  final SavedWorkoutSummary summary;

  @override
  Widget build(BuildContext context) {
    final chips = [
      _HistoryChip(label: 'Sensación: ${summary.feeling}'),
      _HistoryChip(label: 'Dificultad ${summary.difficulty}/10'),
      _HistoryChip(label: summary.cardioCompleted ? 'Cardio sí' : 'Cardio no'),
      if (summary.isFreeWorkout) ...[
        _HistoryChip(label: 'Ejercicios: ${summary.registeredExerciseCount}'),
        _HistoryChip(label: 'Series: ${summary.registeredSetCount}'),
      ] else
        _HistoryChip(label: 'Cambios: ${summary.replacedExercisesCount}'),
      _HistoryChip(label: 'Rendimiento: ${summary.registeredPerformanceCount}'),
      _HistoryChip(label: summary.hasPain ? 'Con molestia' : 'Sin molestia'),
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.workoutName,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              summary.savedAtText,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: chips),
          ],
        ),
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  const _HistoryChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFF00E0A4).withValues(alpha: 0.10),
      side: BorderSide(color: const Color(0xFF00E0A4).withValues(alpha: 0.16)),
    );
  }
}
