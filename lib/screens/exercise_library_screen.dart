import 'package:flutter/material.dart';

import '../exercise_library/exercise_categories.dart';
import '../exercise_library/exercise_library_service.dart';
import '../models/exercise_library_item.dart';
import '../widgets/exercise_image.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  static const _service = ExerciseLibraryService();
  static const _filters = [
    _ExerciseFilter(label: 'Todos'),
    _ExerciseFilter(label: 'Pecho', muscles: [ExerciseMuscles.chest]),
    _ExerciseFilter(label: 'Espalda', muscles: [ExerciseMuscles.back]),
    _ExerciseFilter(
      label: 'Pierna',
      muscles: [
        ExerciseMuscles.quadriceps,
        ExerciseMuscles.glutes,
        ExerciseMuscles.hamstrings,
        ExerciseMuscles.calves,
      ],
    ),
    _ExerciseFilter(label: 'Hombro', muscles: [ExerciseMuscles.shoulders]),
    _ExerciseFilter(label: 'Bíceps', muscles: [ExerciseMuscles.biceps]),
    _ExerciseFilter(label: 'Tríceps', muscles: [ExerciseMuscles.triceps]),
    _ExerciseFilter(label: 'Core', muscles: [ExerciseMuscles.core]),
    _ExerciseFilter(
      label: 'Cardio',
      muscles: [ExerciseMuscles.cardiovascular],
    ),
  ];

  int _selectedFilterIndex = 0;

  List<ExerciseLibraryItem> get _filteredExercises {
    final exercises = _service.getAllExercises();
    final filter = _filters[_selectedFilterIndex];

    if (filter.muscles.isEmpty) {
      return exercises;
    }

    return exercises.where((exercise) {
      return filter.muscles.contains(exercise.primaryMuscle) ||
          exercise.secondaryMuscles.any(
            (muscle) => filter.muscles.contains(muscle),
          );
    }).toList(growable: false);
  }

  void _showExerciseDetail(ExerciseLibraryItem exercise) {
    final alternatives = _service.getAlternativesFor(exercise.id);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F141C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.82,
          minChildSize: 0.45,
          maxChildSize: 0.94,
          builder: (context, scrollController) {
            return _ExerciseDetailSheet(
              exercise: exercise,
              alternatives: alternatives,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercises = _filteredExercises;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca de ejercicios'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Biblioteca de ejercicios',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Consulta técnica, errores comunes y alternativas.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 18),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var index = 0; index < _filters.length; index++) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(_filters[index].label),
                            selected: _selectedFilterIndex == index,
                            onSelected: (_) {
                              setState(() {
                                _selectedFilterIndex = index;
                              });
                            },
                            selectedColor:
                                const Color(0xFF00E0A4).withValues(alpha: 0.22),
                            backgroundColor: const Color(0xFF121821),
                            side: BorderSide(
                              color: _selectedFilterIndex == index
                                  ? const Color(0xFF00E0A4)
                                      .withValues(alpha: 0.35)
                                  : Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '${exercises.length} ejercicios',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.62),
                  ),
                ),
                const SizedBox(height: 12),
                for (final exercise in exercises) ...[
                  _ExerciseLibraryCard(
                    exercise: exercise,
                    onTap: () => _showExerciseDetail(exercise),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseFilter {
  const _ExerciseFilter({
    required this.label,
    this.muscles = const [],
  });

  final String label;
  final List<String> muscles;
}

class _ExerciseLibraryCard extends StatelessWidget {
  const _ExerciseLibraryCard({
    required this.exercise,
    required this.onTap,
  });

  final ExerciseLibraryItem exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.fitness_center_outlined,
                    color: Color(0xFF00E0A4),
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.name,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${exercise.primaryMuscle} · ${exercise.equipment} · ${exercise.movementPattern}',
                          style: TextStyle(
                            height: 1.35,
                            color: Colors.white.withValues(alpha: 0.66),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(label: 'Rol: ${exercise.recommendedRole}'),
                  for (final goal in exercise.compatibleGoals)
                    _InfoChip(label: goal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseDetailSheet extends StatelessWidget {
  const _ExerciseDetailSheet({
    required this.exercise,
    required this.alternatives,
    required this.scrollController,
  });

  final ExerciseLibraryItem exercise;
  final List<ExerciseLibraryItem> alternatives;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 28),
      children: [
        Center(
          child: Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.24),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        const SizedBox(height: 22),
        Text(
          exercise.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _InfoChip(label: exercise.primaryMuscle),
            _InfoChip(label: exercise.equipment),
            _InfoChip(label: exercise.level),
            _InfoChip(label: exercise.recommendedRole),
          ],
        ),
        const SizedBox(height: 18),
        ExerciseImage(imageAsset: exercise.imageAsset),
        const SizedBox(height: 14),
        _DetailBlock(
          title: 'Datos técnicos',
          children: [
            _DetailLine(label: 'Patrón', value: exercise.movementPattern),
            _DetailLine(
              label: 'Músculos secundarios',
              value: exercise.secondaryMuscles.isEmpty
                  ? 'Sin secundarios destacados'
                  : exercise.secondaryMuscles.join(', '),
            ),
            _DetailLine(
              label: 'Objetivos',
              value: exercise.compatibleGoals.join(', '),
            ),
            _DetailLine(
              label: 'Archivo de imagen',
              value: exercise.imageAsset,
            ),
          ],
        ),
        _DetailBlock(
          title: 'Técnica',
          children: [
            for (final step in exercise.techniqueSteps) _BulletLine(text: step),
          ],
        ),
        _DetailBlock(
          title: 'Errores comunes',
          children: [
            for (final mistake in exercise.commonMistakes)
              _BulletLine(text: mistake),
          ],
        ),
        _DetailBlock(
          title: 'Seguridad',
          children: [
            Text(
              exercise.safetyNote,
              style: TextStyle(
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
        _DetailBlock(
          title: 'Alternativas',
          children: [
            if (alternatives.isEmpty)
              Text(
                'Sin alternativas configuradas.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final alternative in alternatives)
                    _InfoChip(label: alternative.name),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

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
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            height: 1.35,
            color: Colors.white.withValues(alpha: 0.72),
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Icon(
              Icons.circle,
              size: 7,
              color: Color(0xFF00E0A4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFF00E0A4).withValues(alpha: 0.12),
      side: BorderSide(
        color: const Color(0xFF00E0A4).withValues(alpha: 0.18),
      ),
    );
  }
}
