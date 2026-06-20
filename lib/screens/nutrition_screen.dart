import 'package:flutter/material.dart';

import '../models/nutrition_meal.dart';
import '../models/user_assessment_data.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/nutrition_meal_card.dart';
import '../widgets/nutrition_mode_card.dart';
import '../widgets/section_title.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  bool _trainingDay = true;

  List<NutritionMeal> get trainingMeals => const [
        NutritionMeal(
          time: '16:15',
          title: 'Comida al despertar',
          description:
              'Proteína alta + carbohidrato controlado + verdura. Ejemplo: pollo, arroz/patata y verdura.',
          goal: 'Activar el día sin llegar pesado al turno.',
        ),
        NutritionMeal(
          time: '20:30',
          title: 'Comida pre-trabajo',
          description:
              'Comida completa y saciante. Ejemplo: huevos, legumbres o carne magra con verduras.',
          goal: 'Llegar al turno con energía estable.',
        ),
        NutritionMeal(
          time: '02:00',
          title: 'Comida del descanso',
          description:
              'Proteína fácil + carbohidrato moderado. Ejemplo: yogur proteico, bocadillo controlado o táper simple.',
          goal: 'Evitar picoteo y bajón de madrugada.',
        ),
        NutritionMeal(
          time: '06:00',
          title: 'Pre-entreno ligero',
          description:
              'Algo digestivo. Ejemplo: yogur proteico, fruta o café si lo toleras.',
          goal: 'Entrenar sin pesadez después del turno.',
        ),
        NutritionMeal(
          time: '08:15',
          title: 'Post-entreno / pre-sueño',
          description:
              'Proteína alta y comida fácil de digerir. Ejemplo: tortilla, queso fresco, yogur proteico o pollo.',
          goal: 'Recuperar sin fastidiar el sueño.',
        ),
      ];

  List<NutritionMeal> get restMeals => const [
        NutritionMeal(
          time: '16:15',
          title: 'Comida al despertar',
          description:
              'Proteína alta + verdura + carbohidrato moderado. Sin hacer una comida pobre.',
          goal: 'Mantener energía y adherencia.',
        ),
        NutritionMeal(
          time: '20:30',
          title: 'Comida pre-trabajo',
          description:
              'Comida saciante con proteína. Ejemplo: pollo, huevos, legumbres o carne magra.',
          goal: 'Reducir hambre durante el turno.',
        ),
        NutritionMeal(
          time: '02:00',
          title: 'Comida del descanso',
          description:
              'Comida controlada y preparada. Evitar improvisar snacks o bollería.',
          goal: 'Controlar la madrugada.',
        ),
        NutritionMeal(
          time: '06:30',
          title: 'Cierre del día',
          description:
              'Comida ligera si hay hambre real. Prioridad: proteína y digestión fácil.',
          goal: 'Dormir mejor y no irte a la cama pesado.',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final meals = _trainingDay ? trainingMeals : restMeals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrición de hoy'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Nutrición adaptada a tu horario',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.data.hasNightShift
                      ? 'Modo turno nocturno activado. Organizamos las comidas alrededor de tu sueño, trabajo y entrenamiento.'
                      : 'Modo horario estándar. Más adelante ajustaremos horas personalizadas.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 22),
                NutritionModeCard(
                  trainingDay: _trainingDay,
                  onChanged: (value) {
                    setState(() => _trainingDay = value);
                  },
                ),
                const SizedBox(height: 22),
                const SectionTitle(
                  icon: Icons.restaurant_outlined,
                  title: 'Comidas recomendadas',
                ),
                const SizedBox(height: 12),
                ...meals.asMap().entries.map(
                      (entry) => NutritionMealCard(
                        number: entry.key + 1,
                        meal: entry.value,
                      ),
                    ),
                const SizedBox(height: 18),
                const DashboardCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Objetivo de agua',
                  description:
                      'Primer objetivo: subir de forma realista. Empieza con 6 vasos al día y después lo llevaremos hacia 2-2,5 litros si lo toleras bien.',
                  chips: [
                    '6 vasos iniciales',
                    'Progresivo',
                    'Sin forzar',
                  ],
                ),
                const SizedBox(height: 18),
                const DashboardCard(
                  icon: Icons.no_food_outlined,
                  title: 'Regla anti-snacks',
                  description:
                      'No se prohíbe todo. La regla inicial es no improvisar de madrugada: si hay hambre, se usa una opción prevista, no bollería ni picoteo automático.',
                  chips: [
                    'Planificar',
                    'No improvisar',
                    'Alta proteína',
                  ],
                ),
                const SizedBox(height: 18),
                const DashboardCard(
                  icon: Icons.shopping_basket_outlined,
                  title: 'Base Mercadona',
                  description:
                      'Más adelante añadiremos productos concretos de Mercadona con gramos, calorías y macros. En esta versión solo fijamos estructura y horarios.',
                  chips: [
                    'Mercadona',
                    'Gramos después',
                    'Macros después',
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Siguiente versión: productos y macros',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Entendido',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
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
