import 'package:flutter/material.dart';

import '../models/user_assessment_data.dart';
import '../models/workout_log_data.dart';
import '../widgets/diagnosis_card.dart';
import 'dashboard_screen.dart';

class WorkoutCompletedScreen extends StatelessWidget {
  const WorkoutCompletedScreen({
    super.key,
    required this.data,
    required this.log,
  });

  final UserAssessmentData data;
  final WorkoutLogData log;

  String get recommendation {
    if (log.hasPain) {
      return 'Próxima recomendación: revisar el ejercicio donde hubo molestia y preparar una alternativa segura.';
    }

    if (log.replacedExercisesCount >= 2) {
      return 'Próxima recomendación: revisar si el gimnasio tenía máquinas ocupadas o si la sesión necesita alternativas más directas.';
    }

    if (log.difficulty >= 8) {
      return 'Próxima recomendación: mantener el mismo nivel. No subimos carga todavía porque la sesión fue dura.';
    }

    if (log.difficulty <= 4 && log.feeling == 'Muy bien') {
      return 'Próxima recomendación: podríamos subir ligeramente la exigencia si se repite esta sensación.';
    }

    return 'Próxima recomendación: repetir estructura y buscar constancia antes de aumentar volumen.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamiento completado'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF00E0A4),
                  size: 64,
                ),
                const SizedBox(height: 18),
                Text(
                  'Buen trabajo, ${data.name}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Este registro será la base para que la app aprenda de tu recuperación, molestias y adherencia.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                DiagnosisCard(
                  icon: Icons.edit_note_outlined,
                  title: 'Resumen registrado',
                  lines: [
                    'Entrenamiento: ${log.workoutName}',
                    'Sensación general: ${log.feeling}',
                    'Dificultad percibida: ${log.difficulty}/10',
                    'Ejercicios cambiados: ${log.replacedExercisesCount}',
                    log.cardioCompleted
                        ? 'Cardio suave completado.'
                        : 'Cardio suave no completado.',
                    log.hasPain
                        ? 'Molestia registrada: ${log.painNote}'
                        : 'Sin dolor o molestia registrada.',
                    if (log.freeNote.isNotEmpty) 'Nota: ${log.freeNote}',
                  ],
                ),
                DiagnosisCard(
                  icon: Icons.psychology_alt_outlined,
                  title: 'Primera decisión adaptativa',
                  lines: [
                    recommendation,
                    'En próximas versiones este resultado modificará automáticamente el plan.',
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => DashboardScreen(data: data),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Volver al panel principal',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

