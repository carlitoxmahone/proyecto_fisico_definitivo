import 'package:flutter/material.dart';

import '../models/saved_habits_summary.dart';
import '../models/saved_workout_summary.dart';
import '../models/user_assessment_data.dart';
import '../services/local_storage_service.dart';
import '../widgets/action_tile.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/main_status_card.dart';
import '../widgets/metric_box.dart';
import '../widgets/section_title.dart';
import 'habits_history_screen.dart';
import 'habits_screen.dart';
import 'nutrition_screen.dart';
import 'weekly_plan_screen.dart';
import 'welcome_screen.dart';
import 'workout_history_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  void _goToNutrition(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NutritionScreen(data: data),
      ),
    );
  }

  void _goToHabits(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HabitsScreen(data: data),
      ),
    );
  }

  void _goToWeeklyPlan(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WeeklyPlanScreen(data: data),
      ),
    );
  }

  void _goToWorkoutHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const WorkoutHistoryScreen(),
      ),
    );
  }

  void _goToHabitsHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const HabitsHistoryScreen(),
      ),
    );
  }

  Widget _buildSavedSummaries(
    SavedWorkoutSummary? lastWorkout,
    SavedHabitsSummary? lastHabits,
  ) {
    if (lastWorkout == null && lastHabits == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        const SectionTitle(
          icon: Icons.save_outlined,
          title: 'Últimos registros',
        ),
        const SizedBox(height: 12),
        if (lastWorkout != null) ...[
          DashboardCard(
            icon: Icons.fitness_center_outlined,
            title: 'Último entrenamiento registrado',
            description:
                '${lastWorkout.workoutName} · ${lastWorkout.savedAtText}',
            chips: [
              'Sensación: ${lastWorkout.feeling}',
              'Dificultad ${lastWorkout.difficulty}/10',
              lastWorkout.cardioCompleted ? 'Cardio sí' : 'Cardio no',
              'Cambios: ${lastWorkout.replacedExercisesCount}',
              'Rendimiento: ${lastWorkout.registeredPerformanceCount}',
              lastWorkout.hasPain ? 'Con molestia' : 'Sin molestia',
            ],
          ),
          const SizedBox(height: 12),
        ],
        if (lastHabits != null)
          DashboardCard(
            icon: Icons.water_drop_outlined,
            title: 'Último registro de hábitos',
            description: 'Guardado: ${lastHabits.savedAtText}',
            chips: [
              '${lastHabits.waterGlasses} vasos',
              '${lastHabits.steps} pasos',
              'Energía ${lastHabits.energy}/10',
              'Snacks ${lastHabits.snackAnxiety}/10',
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final trainingDays =
        int.tryParse(data.trainingDays.replaceAll(',', '.')) ?? 0;

    final recommendedStrengthDays = trainingDays >= 4 ? 3 : trainingDays;
    final optionalDay = trainingDays >= 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel principal'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Hola, ${data.name}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu plan inicial ya está preparado. Ahora puedes cambiar ejercicios si una máquina está ocupada o algo molesta.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                MainStatusCard(data: data),
                FutureBuilder<List<Object?>>(
                  future: Future.wait<Object?>([
                    LocalStorageService.getLastWorkout(),
                    LocalStorageService.getLastHabits(),
                  ]),
                  builder: (context, snapshot) {
                    final values = snapshot.data;
                    return _buildSavedSummaries(
                      values?[0] as SavedWorkoutSummary?,
                      values?[1] as SavedHabitsSummary?,
                    );
                  },
                ),
                const SizedBox(height: 18),
                const SectionTitle(
                  icon: Icons.route_outlined,
                  title: 'Fase actual',
                ),
                const SizedBox(height: 12),
                DashboardCard(
                  icon: Icons.rocket_launch_outlined,
                  title: 'Adaptación inteligente — 4 semanas',
                  description:
                      'No empezamos con 5 días duros. Primero construimos adherencia, técnica, fuerza base y tolerancia al cardio.',
                  chips: [
                    '$recommendedStrengthDays días fuerza',
                    if (optionalDay) '1 día opcional',
                    'A / B / C',
                    'Cambios seguros',
                  ],
                ),
                const SizedBox(height: 18),
                const SectionTitle(
                  icon: Icons.today_outlined,
                  title: 'Acciones de hoy',
                ),
                const SizedBox(height: 12),
                ActionTile(
                  icon: Icons.calendar_month_outlined,
                  title: 'Ver plan semanal',
                  subtitle: 'Semana 1 con entrenamientos A, B y C.',
                  onTap: () => _goToWeeklyPlan(context),
                ),
                ActionTile(
                  icon: Icons.fitness_center_outlined,
                  title: 'Elegir entrenamiento de hoy',
                  subtitle: 'Abre el plan semanal y selecciona Día 1, 3 o 5.',
                  onTap: () => _goToWeeklyPlan(context),
                ),
                ActionTile(
                  icon: Icons.restaurant_outlined,
                  title: 'Ver comidas recomendadas',
                  subtitle: 'Nutrición adaptada a tu horario nocturno.',
                  onTap: () => _goToNutrition(context),
                ),
                ActionTile(
                  icon: Icons.water_drop_outlined,
                  title: 'Registrar agua y pasos',
                  subtitle: 'Registro básico de hábitos diarios.',
                  onTap: () => _goToHabits(context),
                ),
                ActionTile(
                  icon: Icons.history,
                  title: 'Historial de entrenamientos',
                  subtitle: 'Consulta los últimos entrenamientos guardados.',
                  onTap: () => _goToWorkoutHistory(context),
                ),
                ActionTile(
                  icon: Icons.water_drop,
                  title: 'Historial de hábitos',
                  subtitle: 'Consulta los últimos registros de agua y pasos.',
                  onTap: () => _goToHabitsHistory(context),
                ),
                const SizedBox(height: 18),
                const SectionTitle(
                  icon: Icons.insights_outlined,
                  title: 'Métricas iniciales',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    MetricBox(label: 'Peso', value: '${data.weightKg} kg'),
                    MetricBox(label: 'Cintura', value: '${data.waistCm} cm'),
                    MetricBox(label: 'Objetivo', value: data.currentGoal),
                    MetricBox(
                      label: 'Horario',
                      value: data.hasNightShift
                          ? 'Turno nocturno'
                          : 'Horario estándar',
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () => _goToWeeklyPlan(context),
                    child: const Text(
                      'Ver mi semana de entrenamiento',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const WelcomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text('Volver al inicio'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
