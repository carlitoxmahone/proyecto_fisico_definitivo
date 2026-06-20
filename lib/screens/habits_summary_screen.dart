import 'package:flutter/material.dart';

import '../models/habits_log_data.dart';
import '../models/user_assessment_data.dart';
import '../widgets/diagnosis_card.dart';
import 'dashboard_screen.dart';

class HabitsSummaryScreen extends StatelessWidget {
  const HabitsSummaryScreen({
    super.key,
    required this.data,
    required this.log,
  });

  final UserAssessmentData data;
  final HabitsLogData log;

  String get recommendation {
    if (log.energy <= 3) {
      return 'Mañana conviene mantener una sesión suave o mínima. La energía está baja.';
    }

    if (log.snackAnxiety >= 8) {
      return 'Hay que reforzar la comida del descanso y tener una opción prevista anti-snacks.';
    }

    if (log.steps < 2500) {
      return 'Mañana el objetivo será sumar algo más de movimiento sin forzar.';
    }

    return 'Buen registro. Mantén estructura y constancia antes de subir exigencia.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro guardado'),
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
                const Text(
                  'Registro diario guardado',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'De momento se guarda solo en memoria. Más adelante lo guardaremos de forma persistente.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                DiagnosisCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Hábitos registrados',
                  lines: [
                    'Agua: ${log.waterGlasses} vasos',
                    'Pasos: ${log.steps}',
                    'Energía: ${log.energy}/10',
                    'Ansiedad por snacks: ${log.snackAnxiety}/10',
                    if (log.note.isNotEmpty) 'Nota: ${log.note}',
                  ],
                ),
                DiagnosisCard(
                  icon: Icons.psychology_alt_outlined,
                  title: 'Primera decisión adaptativa',
                  lines: [
                    recommendation,
                    'Estos datos se usarán después para ajustar entrenamiento, cardio y nutrición.',
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
