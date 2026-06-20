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

  double _progressValue(int current, int target) {
    if (target <= 0) return 0;
    return (current / target).clamp(0, 1).toDouble();
  }

  String _motivationMessage(
    List<SavedWorkoutSummary> workoutHistory,
    List<SavedHabitsSummary> habitsHistory,
  ) {
    final workouts = workoutHistory.length;
    final habits = habitsHistory.length;
    final hasPendingCardio =
        workoutHistory.isNotEmpty && !workoutHistory.first.cardioCompleted;

    if (workouts == 0) {
      return 'Hoy puede ser un buen día para empezar.';
    }

    if (hasPendingCardio) {
      return 'Te falta sumar un poco de cardio suave.';
    }

    if (workouts >= 3 && habits >= 5) {
      return 'Muy buena constancia, sigue así.';
    }

    return 'Buen comienzo, sigue construyendo el hábito.';
  }

  String _streakMessage(int streak) {
    if (streak >= 5) return 'No rompas la cadena';
    if (streak >= 2) return 'Buen ritmo';
    return 'Hoy toca sumar';
  }

  Widget _buildVisualDashboard(
    BuildContext context,
    SavedWorkoutSummary? lastWorkout,
    SavedHabitsSummary? lastHabits,
    List<SavedWorkoutSummary> workoutHistory,
    List<SavedHabitsSummary> habitsHistory,
  ) {
    const workoutGoal = 3;
    const habitsGoal = 5;

    final workoutsDone = workoutHistory.length.clamp(0, workoutGoal).toInt();
    final habitsDone = habitsHistory.length.clamp(0, habitsGoal).toInt();
    final streak =
        (workoutHistory.length + habitsHistory.length).clamp(0, 7).toInt();
    final cardioCompleted = lastWorkout?.cardioCompleted ?? false;
    final waterGlasses = lastHabits?.waterGlasses ?? 0;
    final steps = lastHabits?.steps ?? 0;
    final recommendedTitle = workoutHistory.isEmpty
        ? 'Ir al plan semanal'
        : habitsHistory.isEmpty
            ? 'Registrar hábitos de hoy'
            : 'Ver historial de entrenamientos';
    final recommendedDescription = workoutHistory.isEmpty
        ? 'Elige Día 1, 3 o 5 y completa tu primera sesión.'
        : habitsHistory.isEmpty
            ? 'Añade agua, pasos y energía para completar la foto del día.'
            : 'Revisa tu progreso reciente y sigue construyendo constancia.';
    final recommendedAction = workoutHistory.isEmpty
        ? () => _goToWeeklyPlan(context)
        : habitsHistory.isEmpty
            ? () => _goToHabits(context)
            : () => _goToWorkoutHistory(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _WeeklyProgressCard(
          workoutsDone: workoutsDone,
          workoutGoal: workoutGoal,
          habitsDone: habitsDone,
          habitsGoal: habitsGoal,
          workoutProgress: _progressValue(workoutsDone, workoutGoal),
          habitsProgress: _progressValue(habitsDone, habitsGoal),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _StreakCard(
                streak: streak,
                message: _streakMessage(streak),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MotivationCard(
                message: _motivationMessage(workoutHistory, habitsHistory),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const SectionTitle(
          icon: Icons.bolt_outlined,
          title: 'Estado de hoy',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _StatusIndicatorCard(
              icon: Icons.water_drop_outlined,
              title: 'Agua',
              value: '$waterGlasses vasos',
              progress: _progressValue(waterGlasses, 8),
            ),
            _StatusIndicatorCard(
              icon: Icons.directions_walk_outlined,
              title: 'Pasos',
              value: '$steps pasos',
              progress: _progressValue(steps, 5000),
            ),
            _StatusIndicatorCard(
              icon: Icons.fitness_center_outlined,
              title: 'Entreno',
              value: lastWorkout == null ? 'Pendiente' : 'Registrado',
              progress: lastWorkout == null ? 0 : 1,
            ),
            _StatusIndicatorCard(
              icon: Icons.favorite_border,
              title: 'Cardio',
              value: cardioCompleted ? 'Completado' : 'Pendiente',
              progress: cardioCompleted ? 1 : 0,
            ),
          ],
        ),
        const SizedBox(height: 18),
        _RecommendedActionCard(
          title: recommendedTitle,
          description: recommendedDescription,
          onPressed: recommendedAction,
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
                    LocalStorageService.getWorkoutHistory(),
                    LocalStorageService.getHabitsHistory(),
                  ]),
                  builder: (context, snapshot) {
                    final values = snapshot.data;
                    final lastWorkout = values?[0] as SavedWorkoutSummary?;
                    final lastHabits = values?[1] as SavedHabitsSummary?;
                    final workoutHistory =
                        values?[2] as List<SavedWorkoutSummary>? ?? [];
                    final habitsHistory =
                        values?[3] as List<SavedHabitsSummary>? ?? [];

                    return Column(
                      children: [
                        _buildVisualDashboard(
                          context,
                          lastWorkout,
                          lastHabits,
                          workoutHistory,
                          habitsHistory,
                        ),
                        _buildSavedSummaries(lastWorkout, lastHabits),
                      ],
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

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard({
    required this.workoutsDone,
    required this.workoutGoal,
    required this.habitsDone,
    required this.habitsGoal,
    required this.workoutProgress,
    required this.habitsProgress,
  });

  final int workoutsDone;
  final int workoutGoal;
  final int habitsDone;
  final int habitsGoal;
  final double workoutProgress;
  final double habitsProgress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF101F1B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: const Color(0xFF00E0A4).withValues(alpha: 0.28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.auto_graph_outlined,
                  color: Color(0xFF00E0A4),
                  size: 34,
                ),
                SizedBox(width: 12),
                Text(
                  'Semana en marcha',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _ProgressLine(
              label: 'Entrenamientos',
              value: '$workoutsDone/$workoutGoal',
              progress: workoutProgress,
            ),
            const SizedBox(height: 14),
            _ProgressLine(
              label: 'Hábitos registrados',
              value: '$habitsDone/$habitsGoal',
              progress: habitsProgress,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({
    required this.label,
    required this.value,
    required this.progress,
  });

  final String label;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.10),
            color: const Color(0xFF00E0A4),
          ),
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({
    required this.streak,
    required this.message,
  });

  final int streak;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _CompactVisualCard(
      icon: Icons.local_fire_department_outlined,
      title: 'Racha actual',
      value: '$streak',
      subtitle: message,
    );
  }
}

class _MotivationCard extends StatelessWidget {
  const _MotivationCard({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return _CompactVisualCard(
      icon: Icons.psychology_alt_outlined,
      title: 'Mensaje de hoy',
      value: 'Vamos',
      subtitle: message,
    );
  }
}

class _CompactVisualCard extends StatelessWidget {
  const _CompactVisualCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

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
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF00E0A4),
              size: 30,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.55),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                height: 1.35,
                color: Colors.white.withValues(alpha: 0.70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusIndicatorCard extends StatelessWidget {
  const _StatusIndicatorCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.progress,
  });

  final IconData icon;
  final String title;
  final String value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185,
      child: Card(
        color: const Color(0xFF121821),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: const Color(0xFF00E0A4),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.68),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  value: progress,
                  backgroundColor: Colors.white.withValues(alpha: 0.10),
                  color: const Color(0xFF00E0A4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendedActionCard extends StatelessWidget {
  const _RecommendedActionCard({
    required this.title,
    required this.description,
    required this.onPressed,
  });

  final String title;
  final String description;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF101F1B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: const Color(0xFF00E0A4).withValues(alpha: 0.24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const Icon(
              Icons.flag_outlined,
              color: Color(0xFF00E0A4),
              size: 32,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Próxima acción recomendada',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF00E0A4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      height: 1.35,
                      color: Colors.white.withValues(alpha: 0.70),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: onPressed,
              child: const Text('Abrir'),
            ),
          ],
        ),
      ),
    );
  }
}
