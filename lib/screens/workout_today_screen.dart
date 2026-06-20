import 'package:flutter/material.dart';

import '../models/user_assessment_data.dart';
import '../models/workout_exercise.dart';
import '../models/workout_log_data.dart';
import '../models/workout_template.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/exercise_card.dart';
import '../widgets/section_title.dart';
import '../widgets/slider_card.dart';
import '../widgets/workout_summary_card.dart';
import 'workout_completed_screen.dart';

class WorkoutTodayScreen extends StatefulWidget {
  const WorkoutTodayScreen({
    super.key,
    required this.data,
    required this.workout,
  });

  final UserAssessmentData data;
  final WorkoutTemplate workout;

  @override
  State<WorkoutTodayScreen> createState() => _WorkoutTodayScreenState();
}

class _WorkoutTodayScreenState extends State<WorkoutTodayScreen> {
  final _logFormKey = GlobalKey<FormState>();

  String _feeling = 'Normal';
  double _difficulty = 5;
  bool _hasPain = false;
  bool _cardioCompleted = false;

  late List<WorkoutExercise> _currentExercises;

  final _painNoteController = TextEditingController();
  final _freeNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentExercises = List<WorkoutExercise>.from(widget.workout.exercises);
  }

  @override
  void dispose() {
    _painNoteController.dispose();
    _freeNoteController.dispose();
    super.dispose();
  }

  int get replacedExercisesCount {
    return _currentExercises.where((exercise) => exercise.wasReplaced).length;
  }

  void _completeWorkout() {
    if (!_logFormKey.currentState!.validate()) return;

    final log = WorkoutLogData(
      workoutName: widget.workout.name,
      feeling: _feeling,
      difficulty: _difficulty.round(),
      hasPain: _hasPain,
      painNote: _painNoteController.text.trim(),
      cardioCompleted: _cardioCompleted,
      freeNote: _freeNoteController.text.trim(),
      replacedExercisesCount: replacedExercisesCount,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutCompletedScreen(
          data: widget.data,
          log: log,
        ),
      ),
    );
  }

  String? _painValidator(String? value) {
    if (!_hasPain) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Indica dónde has notado la molestia';
    }

    return null;
  }

  void _replaceExercise(int index) {
    final exercise = _currentExercises[index];

    if (exercise.alternatives.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Este ejercicio aún no tiene alternativas.'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B0F14),
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            children: [
              Text(
                'Cambiar ${exercise.name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Elige una alternativa si la máquina está ocupada, no tienes el material o notas molestia.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.white.withValues(alpha: 0.68),
                ),
              ),
              const SizedBox(height: 18),
              ...exercise.alternatives.map(
                (alternative) => Card(
                  color: const Color(0xFF121821),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.swap_horiz,
                      color: Color(0xFF00E0A4),
                    ),
                    title: Text(
                      alternative.name,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(
                      alternative.reason,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentExercises[index] =
                            exercise.replacedBy(alternative);
                      });

                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${exercise.name} cambiado por ${alternative.name}',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNightShiftText =
        widget.data.hasNightShift ? 'Post-turno nocturno' : 'Horario estándar';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.name),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: Form(
              key: _logFormKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    widget.workout.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.workout.focus,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 22),
                  WorkoutSummaryCard(
                    goal: widget.data.currentGoal,
                    schedule: hasNightShiftText,
                    workoutName: widget.workout.subtitle,
                  ),
                  if (replacedExercisesCount > 0) ...[
                    const SizedBox(height: 14),
                    DashboardCard(
                      icon: Icons.swap_horiz,
                      title: 'Ejercicios cambiados',
                      description:
                          'Has cambiado $replacedExercisesCount ejercicio(s) en esta sesión. La app lo tendrá en cuenta en próximas versiones.',
                      chips: const [
                        'Adaptación',
                        'Seguridad',
                        'Flexibilidad',
                      ],
                    ),
                  ],
                  const SizedBox(height: 22),
                  const SectionTitle(
                    icon: Icons.fitness_center_outlined,
                    title: 'Ejercicios',
                  ),
                  const SizedBox(height: 12),
                  ..._currentExercises.asMap().entries.map(
                        (entry) => ExerciseCard(
                          number: entry.key + 1,
                          exercise: entry.value,
                          onReplace: () => _replaceExercise(entry.key),
                        ),
                      ),
                  const SizedBox(height: 18),
                  const DashboardCard(
                    icon: Icons.directions_walk_outlined,
                    title: 'Cardio suave',
                    description:
                        'Después de la fuerza: caminar 15-20 minutos a ritmo cómodo. La prioridad es crear hábito sin reventarte.',
                    chips: [
                      '15-20 min',
                      'Ritmo cómodo',
                      'Sin impacto',
                    ],
                  ),
                  const SizedBox(height: 18),
                  const DashboardCard(
                    icon: Icons.warning_amber_outlined,
                    title: 'Regla de seguridad',
                    description:
                        'Si aparece dolor articular raro, mareo, pinchazo fuerte o molestia que cambia tu técnica, paras el ejercicio y lo registramos para adaptarlo.',
                    chips: [
                      'Sin ego',
                      'Técnica primero',
                      'Progresión gradual',
                    ],
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle(
                    icon: Icons.edit_note_outlined,
                    title: 'Registro del entrenamiento',
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _feeling,
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
                      DropdownMenuItem(
                        value: 'Normal',
                        child: Text('Normal'),
                      ),
                      DropdownMenuItem(
                        value: 'Bien',
                        child: Text('Bien'),
                      ),
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
                      'He completado el cardio suave',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      'Caminar 15-20 minutos después de la fuerza.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
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
                    subtitle: Text(
                      'Esto servirá para adaptar ejercicios en próximas versiones.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
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
                        hintText: 'Ejemplo: hombro derecho en press de pecho',
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
                          'Ejemplo: fui cansado, pero terminé todo con buena técnica.',
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: _completeWorkout,
                      child: const Text(
                        'Completar y ver resumen',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Volver'),
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

