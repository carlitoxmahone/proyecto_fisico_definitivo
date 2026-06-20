import 'package:flutter/material.dart';

import '../models/saved_habits_summary.dart';
import '../services/local_storage_service.dart';
import '../widgets/section_title.dart';

class HabitsHistoryScreen extends StatefulWidget {
  const HabitsHistoryScreen({super.key});

  @override
  State<HabitsHistoryScreen> createState() => _HabitsHistoryScreenState();
}

class _HabitsHistoryScreenState extends State<HabitsHistoryScreen> {
  late final Future<List<SavedHabitsSummary>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = LocalStorageService.getHabitsHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de hábitos'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: FutureBuilder<List<SavedHabitsSummary>>(
              future: _historyFuture,
              builder: (context, snapshot) {
                final history = snapshot.data ?? [];

                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const SectionTitle(
                      icon: Icons.history,
                      title: 'Historial de hábitos',
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
                            'Aún no hay registros de hábitos guardados. Guarda uno para verlo aquí.',
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
                        (item) => _HabitsHistoryCard(summary: item),
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

class _HabitsHistoryCard extends StatelessWidget {
  const _HabitsHistoryCard({
    required this.summary,
  });

  final SavedHabitsSummary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.savedAtText,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _HistoryChip(label: '${summary.waterGlasses} vasos'),
                _HistoryChip(label: '${summary.steps} pasos'),
                _HistoryChip(label: 'Energía ${summary.energy}/10'),
                _HistoryChip(
                  label: 'Snacks ${summary.snackAnxiety}/10',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  const _HistoryChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFF00E0A4).withValues(alpha: 0.10),
      side: BorderSide(
        color: const Color(0xFF00E0A4).withValues(alpha: 0.16),
      ),
    );
  }
}
