import 'package:flutter/material.dart';

import '../exercise_library/exercise_library_service.dart';
import '../models/exercise_library_item.dart';
import '../models/exercise_performance_log.dart';
import '../models/exercise_set_log.dart';
import '../models/saved_workout_summary.dart';
import '../models/user_assessment_data.dart';
import '../services/local_storage_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/section_title.dart';
import '../widgets/slider_card.dart';

class FreeWorkoutScreen extends StatefulWidget {
  const FreeWorkoutScreen({super.key, required this.data});

  final UserAssessmentData data;

  @override
  State<FreeWorkoutScreen> createState() => _FreeWorkoutScreenState();
}

class _FreeWorkoutScreenState extends State<FreeWorkoutScreen> {
  static const _exerciseLibraryService = ExerciseLibraryService();
  final _logFormKey = GlobalKey<FormState>();
  final _painNoteController = TextEditingController();
  final _freeNoteController = TextEditingController();
  final _searchController = TextEditingController();

  final List<_FreeWorkoutExerciseLog> _selectedExercises = [];

  String _feeling = 'Normal';
  double _difficulty = 5;
  bool _hasPain = false;
  bool _cardioCompleted = false;
  String _searchText = '';

  List<ExerciseLibraryItem> get _allExercises {
    return _exerciseLibraryService.getAllExercises();
  }

  List<ExerciseLibraryItem> get _filteredExercises {
    final query = _searchText.trim().toLowerCase();
    if (query.isEmpty) return _allExercises;

    return _allExercises
        .where((exercise) {
          return exercise.name.toLowerCase().contains(query) ||
              exercise.primaryMuscle.toLowerCase().contains(query) ||
              exercise.equipment.toLowerCase().contains(query) ||
              exercise.recommendedRole.toLowerCase().contains(query);
        })
        .toList(growable: false);
  }

  List<ExercisePerformanceLog> get _performanceLogs {
    return _selectedExercises
        .map((exerciseLog) {
          return ExercisePerformanceLog(
            exerciseName: exerciseLog.exercise.name,
            sets: exerciseLog.sets
                .map((setLog) {
                  return ExerciseSetLog(
                    kg: setLog.kgController.text.trim(),
                    reps: setLog.repsController.text.trim(),
                  );
                })
                .toList(growable: false),
          );
        })
        .toList(growable: false);
  }

  int get _registeredExerciseCount {
    return _performanceLogs.where((log) => log.hasData).length;
  }

  int get _registeredSetCount {
    return _performanceLogs.fold<int>(0, (total, log) {
      return total + log.sets.where((setLog) => setLog.hasData).length;
    });
  }

  @override
  void dispose() {
    for (final exerciseLog in _selectedExercises) {
      exerciseLog.dispose();
    }
    _painNoteController.dispose();
    _freeNoteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addExercise(ExerciseLibraryItem exercise) {
    final alreadyAdded = _selectedExercises.any(
      (exerciseLog) => exerciseLog.exercise.id == exercise.id,
    );

    if (alreadyAdded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este ejercicio ya está añadido.')),
      );
      return;
    }

    setState(() {
      _selectedExercises.add(_FreeWorkoutExerciseLog(exercise));
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${exercise.name} añadido.')));
  }

  void _removeExercise(int index) {
    final removed = _selectedExercises.removeAt(index);
    removed.dispose();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${removed.exercise.name} quitado.')),
    );
  }

  void _addSet(int exerciseIndex) {
    setState(() {
      _selectedExercises[exerciseIndex].addSet();
    });
  }

  Future<void> _saveWorkout() async {
    if (!_logFormKey.currentState!.validate()) return;

    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Añade al menos un ejercicio')),
      );
      return;
    }

    if (_registeredSetCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registra al menos una serie con kg o reps.'),
        ),
      );
      return;
    }

    final savedAt = DateTime.now().toLocal();
    final summary = SavedWorkoutSummary(
      workoutName: 'Entrenamiento libre',
      feeling: _feeling,
      difficulty: _difficulty.round(),
      cardioCompleted: _cardioCompleted,
      replacedExercisesCount: 0,
      registeredPerformanceCount: _registeredExerciseCount,
      hasPain: _hasPain,
      savedAtText: savedAt.toString(),
      savedAtIso: savedAt.toIso8601String(),
      workoutType: 'libre',
      registeredExerciseCount: _selectedExercises.length,
      registeredSetCount: _registeredSetCount,
    );

    await LocalStorageService.saveLastWorkout(summary);
    await LocalStorageService.saveWorkoutToHistory(summary);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Entrenamiento libre guardado.')),
    );
    Navigator.of(context).pop(true);
  }

  String? _painValidator(String? value) {
    if (!_hasPain) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Indica dónde has notado la molestia';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entrenamiento libre')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: Form(
              key: _logFormKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Text(
                    'Entrenamiento libre',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Elige los ejercicios que hagas hoy y registra tus series.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 22),
                  DashboardCard(
                    icon: Icons.add_task_outlined,
                    title: 'Sesión sin plan cerrado',
                    description:
                        'Añade ejercicios desde la biblioteca, apunta kg y reps, y guarda el entrenamiento en el historial.',
                    chips: [
                      '${_selectedExercises.length} ejercicios',
                      'Series: $_registeredSetCount',
                      'Cardio ${_cardioCompleted ? 'sí' : 'no'}',
                    ],
                  ),
                  const SizedBox(height: 22),
                  const SectionTitle(
                    icon: Icons.search_outlined,
                    title: 'Elegir ejercicios',
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Buscar en la biblioteca',
                      hintText: 'Ejercicio, músculo, material o rol',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() => _searchText = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  ..._filteredExercises
                      .take(8)
                      .map(
                        (exercise) => _ExercisePickerTile(
                          exercise: exercise,
                          isAdded: _selectedExercises.any(
                            (log) => log.exercise.id == exercise.id,
                          ),
                          onAdd: () => _addExercise(exercise),
                        ),
                      ),
                  const SizedBox(height: 22),
                  const SectionTitle(
                    icon: Icons.fitness_center_outlined,
                    title: 'Ejercicios añadidos',
                  ),
                  const SizedBox(height: 12),
                  if (_selectedExercises.isEmpty)
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
                          'Todavía no has añadido ejercicios. Busca arriba y pulsa Añadir.',
                          style: TextStyle(
                            height: 1.4,
                            color: Colors.white.withValues(alpha: 0.72),
                          ),
                        ),
                      ),
                    )
                  else
                    ..._selectedExercises.asMap().entries.map(
                      (entry) => _SelectedExerciseCard(
                        index: entry.key,
                        exerciseLog: entry.value,
                        onAddSet: () => _addSet(entry.key),
                        onRemove: () => _removeExercise(entry.key),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const SectionTitle(
                    icon: Icons.edit_note_outlined,
                    title: 'Datos finales',
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _feeling,
                    decoration: const InputDecoration(
                      labelText: 'Sensación general',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Muy mal',
                        child: Text('Muy mal'),
                      ),
                      DropdownMenuItem(
                        value: 'Cansado',
                        child: Text('Cansado'),
                      ),
                      DropdownMenuItem(value: 'Normal', child: Text('Normal')),
                      DropdownMenuItem(value: 'Bien', child: Text('Bien')),
                      DropdownMenuItem(
                        value: 'Muy bien',
                        child: Text('Muy bien'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _feeling = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  SliderCard(
                    title: 'Dificultad percibida',
                    value: _difficulty,
                    label: '${_difficulty.round()}/10',
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() => _difficulty = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    value: _cardioCompleted,
                    activeThumbColor: const Color(0xFF00E0A4),
                    title: const Text(
                      'Cardio completado',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    onChanged: (value) {
                      setState(() => _cardioCompleted = value);
                    },
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    value: _hasPain,
                    activeThumbColor: const Color(0xFFFFC857),
                    title: const Text(
                      'He notado dolor o molestia',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    onChanged: (value) {
                      setState(() => _hasPain = value);
                    },
                  ),
                  if (_hasPain) ...[
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _painNoteController,
                      validator: _painValidator,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Dónde has notado la molestia',
                        hintText: 'Ejemplo: rodilla derecha en prensa',
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _freeNoteController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Nota libre',
                      hintText:
                          'Ejemplo: entreno corto, buena técnica y descansos largos.',
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: _saveWorkout,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text(
                        'Guardar entrenamiento',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Volver sin guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExercisePickerTile extends StatelessWidget {
  const _ExercisePickerTile({
    required this.exercise,
    required this.isAdded,
    required this.onAdd,
  });

  final ExerciseLibraryItem exercise;
  final bool isAdded;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: ListTile(
        title: Text(
          exercise.name,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          '${exercise.primaryMuscle} · ${exercise.equipment} · ${exercise.recommendedRole}',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.62)),
        ),
        trailing: FilledButton.icon(
          onPressed: isAdded ? null : onAdd,
          icon: Icon(isAdded ? Icons.check : Icons.add),
          label: Text(isAdded ? 'Añadido' : 'Añadir'),
        ),
      ),
    );
  }
}

class _SelectedExerciseCard extends StatelessWidget {
  const _SelectedExerciseCard({
    required this.index,
    required this.exerciseLog,
    required this.onAddSet,
    required this.onRemove,
  });

  final int index;
  final _FreeWorkoutExerciseLog exerciseLog;
  final VoidCallback onAddSet;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final exercise = exerciseLog.exercise;

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${exercise.name}',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _InfoChip(label: exercise.primaryMuscle),
                          _InfoChip(label: exercise.equipment),
                          _InfoChip(label: exercise.recommendedRole),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Quitar ejercicio',
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...exerciseLog.sets.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 66,
                      child: Text(
                        'Serie ${entry.key + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: entry.value.kgController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(labelText: 'kg'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: entry.value.repsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'reps'),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                OutlinedButton.icon(
                  onPressed: onAddSet,
                  icon: const Icon(Icons.add),
                  label: const Text('Añadir serie'),
                ),
                OutlinedButton.icon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Quitar ejercicio'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

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

class _FreeWorkoutExerciseLog {
  _FreeWorkoutExerciseLog(this.exercise)
    : sets = List.generate(3, (_) => _FreeWorkoutSetLog());

  final ExerciseLibraryItem exercise;
  final List<_FreeWorkoutSetLog> sets;

  void addSet() {
    sets.add(_FreeWorkoutSetLog());
  }

  void dispose() {
    for (final setLog in sets) {
      setLog.dispose();
    }
  }
}

class _FreeWorkoutSetLog {
  final kgController = TextEditingController();
  final repsController = TextEditingController();

  void dispose() {
    kgController.dispose();
    repsController.dispose();
  }
}
