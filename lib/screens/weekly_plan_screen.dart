import 'package:flutter/material.dart';

import '../data/app_workout_templates.dart';
import '../models/user_assessment_data.dart';
import '../models/weekly_plan_day.dart';
import '../models/workout_template.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/section_title.dart';
import '../widgets/weekly_plan_day_card.dart';
import 'workout_today_screen.dart';

class WeeklyPlanScreen extends StatelessWidget {
  const WeeklyPlanScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  List<WeeklyPlanDay> get weekOne => const [
        WeeklyPlanDay(
          day: 'Día 1',
          title: 'Full body A',
          type: 'Fuerza',
          description:
              'Sesión de cuerpo completo con máquinas y técnica controlada.',
          focus: 'Aprender movimientos, no buscar máximo peso.',
          icon: Icons.fitness_center_outlined,
          workoutTemplate: AppWorkoutTemplates.fullBodyA,
        ),
        WeeklyPlanDay(
          day: 'Día 2',
          title: 'Cardio suave / pasos',
          type: 'Cardio',
          description:
              'Caminar a ritmo cómodo y subir pasos sin impacto para las rodillas.',
          focus: 'Crear hábito cardiovascular sin agotarte.',
          icon: Icons.directions_walk_outlined,
        ),
        WeeklyPlanDay(
          day: 'Día 3',
          title: 'Full body B',
          type: 'Fuerza',
          description:
              'Segunda sesión de fuerza con patrón distinto y control de fatiga.',
          focus: 'Repetir técnica y ganar confianza.',
          icon: Icons.fitness_center_outlined,
          workoutTemplate: AppWorkoutTemplates.fullBodyB,
        ),
        WeeklyPlanDay(
          day: 'Día 4',
          title: 'Descanso activo',
          type: 'Recuperación',
          description:
              'Movimiento ligero, hidratación y sueño. Nada de sesión dura.',
          focus: 'Llegar fresco al siguiente entrenamiento.',
          icon: Icons.self_improvement_outlined,
        ),
        WeeklyPlanDay(
          day: 'Día 5',
          title: 'Full body C',
          type: 'Fuerza',
          description:
              'Tercera sesión de fuerza de la semana. Cierre técnico y controlado.',
          focus: 'Cerrar la semana con buena ejecución.',
          icon: Icons.fitness_center_outlined,
          workoutTemplate: AppWorkoutTemplates.fullBodyC,
        ),
        WeeklyPlanDay(
          day: 'Día 6',
          title: 'Opcional adaptativo',
          type: 'Opcional',
          description:
              'Solo se hace si la energía, el sueño y las molestias acompañan.',
          focus: 'Puede ser cardio suave, movilidad o sesión mínima.',
          icon: Icons.tune_outlined,
        ),
        WeeklyPlanDay(
          day: 'Día 7',
          title: 'Descanso',
          type: 'Descanso',
          description:
              'Descanso real. Revisar cintura, peso medio, agua, pasos y sensaciones.',
          focus: 'Preparar la siguiente semana sin quemarte.',
          icon: Icons.bedtime_outlined,
        ),
      ];

  void _openWorkout(BuildContext context, WorkoutTemplate workout) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutTodayScreen(
          data: data,
          workout: workout,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan semanal'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Semana 1 — Adaptación inteligente',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Los días de fuerza tienen sesiones diferentes. Toca el Día 1, Día 3 o Día 5 para abrir su entrenamiento concreto.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 22),
                const DashboardCard(
                  icon: Icons.flag_outlined,
                  title: 'Objetivo de la semana',
                  description:
                      'Empezar con 3 sesiones de fuerza diferentes, cardio suave y hábitos mínimos. La prioridad es adherencia, técnica y control de fatiga.',
                  chips: [
                    'Full body A',
                    'Full body B',
                    'Full body C',
                    'Cambios seguros',
                    'Sin machaque',
                  ],
                ),
                const SizedBox(height: 18),
                const SectionTitle(
                  icon: Icons.calendar_month_outlined,
                  title: 'Distribución semanal',
                ),
                const SizedBox(height: 12),
                ...weekOne.map(
                  (planDay) => WeeklyPlanDayCard(
                    day: planDay,
                    onTap: planDay.workoutTemplate == null
                        ? null
                        : () => _openWorkout(
                              context,
                              planDay.workoutTemplate!,
                            ),
                  ),
                ),
                const SizedBox(height: 18),
                const DashboardCard(
                  icon: Icons.psychology_alt_outlined,
                  title: 'Regla adaptativa',
                  description:
                      'Si registras energía muy baja, dolor o ansiedad alta por snacks, el día opcional no debe convertirse en una sesión dura. La app lo usará después para ajustar automáticamente.',
                  chips: [
                    'Energía',
                    'Dolor',
                    'Sueño',
                    'Adherencia',
                  ],
                ),
                const SizedBox(height: 28),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Volver al panel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
