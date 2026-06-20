import 'package:flutter/material.dart';

import '../models/user_assessment_data.dart';
import '../widgets/diagnosis_card.dart';
import '../widgets/section_title.dart';
import 'dashboard_screen.dart';

class DiagnosisScreen extends StatelessWidget {
  const DiagnosisScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  void _goToDashboard(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => DashboardScreen(data: data),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final waist = num.tryParse(data.waistCm.replaceAll(',', '.')) ?? 0;
    final height = num.tryParse(data.heightCm.replaceAll(',', '.')) ?? 0;
    final waistHeightRatio = height > 0 ? waist / height : 0;

    final isRecomposition =
        data.currentGoal.toLowerCase().contains('recomposición');

    final showNoBulkWarning =
        data.visualGoal == 'Grande y musculoso' && waistHeightRatio >= 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnóstico inicial'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Tu punto de partida',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Este diagnóstico es una primera interpretación. Más adelante la app lo ajustará con tus entrenamientos, medidas, energía y adherencia.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                DiagnosisCard(
                  icon: Icons.person_outline,
                  title: 'Perfil físico',
                  lines: [
                    '${data.name}, ${data.age} años',
                    '${data.heightCm} cm · ${data.weightKg} kg',
                    'Cintura: ${data.waistCm} cm',
                    if (waistHeightRatio > 0)
                      'Ratio cintura/altura aproximada: ${waistHeightRatio.toStringAsFixed(2)}',
                  ],
                ),
                DiagnosisCard(
                  icon: Icons.flag_outlined,
                  title: 'Objetivo',
                  lines: [
                    'Objetivo actual: ${data.currentGoal}',
                    'Objetivo visual: ${data.visualGoal}',
                    if (isRecomposition)
                      'Estrategia inicial: perder grasa y ganar músculo de forma progresiva.',
                    if (showNoBulkWarning)
                      'No se recomienda empezar con volumen: primero reduciremos cintura mientras subimos fuerza.',
                  ],
                ),
                DiagnosisCard(
                  icon: Icons.schedule_outlined,
                  title: 'Horario y entrenamiento',
                  lines: [
                    'Días disponibles: ${data.trainingDays} por semana',
                    if (data.hasNightShift)
                      'Modo turno nocturno activado.'
                    else
                      'Horario estándar activado.',
                    'Fase recomendada: adaptación inicial.',
                  ],
                ),
                DiagnosisCard(
                  icon: Icons.auto_graph_outlined,
                  title: 'Estrategia recomendada',
                  lines: [
                    '3 días de fuerza full body estratégica.',
                    'Cardio suave y progresivo.',
                    'Control de cintura, fuerza, pasos, agua y energía.',
                    'Nutrición adaptada al horario real.',
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () => _goToDashboard(context),
                    child: const Text(
                      'Crear mi primer plan',
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
                  child: const Text('Editar respuestas'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

