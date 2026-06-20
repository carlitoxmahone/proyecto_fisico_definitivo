import 'package:flutter/material.dart';

import '../models/habits_log_data.dart';
import '../models/saved_habits_summary.dart';
import '../models/user_assessment_data.dart';
import '../services/local_storage_service.dart';
import '../widgets/info_text.dart';
import '../widgets/section_title.dart';
import '../widgets/slider_card.dart';
import 'habits_summary_screen.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  double _waterGlasses = 4;
  double _steps = 1000;
  double _energy = 4;
  double _snackAnxiety = 5;

  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String get waterMessage {
    if (_waterGlasses < 6) {
      return 'Objetivo inicial: subir poco a poco hasta 6 vasos al día.';
    }

    if (_waterGlasses <= 8) {
      return 'Buen nivel inicial de agua. Mantén este rango unos días.';
    }

    return 'Muy bien, pero evita forzarte. La hidratación debe ser sostenible.';
  }

  String get stepsMessage {
    if (_steps < 2500) {
      return 'Punto de partida bajo. Objetivo: caminar un poco más sin agobiarte.';
    }

    if (_steps < 5000) {
      return 'Buen avance inicial. Esto ya empieza a ayudar al gasto diario.';
    }

    return 'Muy buen nivel para esta fase. Mantén constancia antes de subir más.';
  }

  String get energyMessage {
    if (_energy <= 3) {
      return 'Energía baja. Mañana la app debería evitar subir exigencia.';
    }

    if (_energy <= 6) {
      return 'Energía media. Mantendremos el plan sin apretar demasiado.';
    }

    return 'Buena energía. Si se repite, podremos progresar con más seguridad.';
  }

  String get snackMessage {
    if (_snackAnxiety >= 8) {
      return 'Ansiedad alta por snacks. Hay que reforzar comida planificada de madrugada.';
    }

    if (_snackAnxiety >= 5) {
      return 'Ansiedad moderada. Conviene tener una opción prevista y alta en proteína.';
    }

    return 'Buen control del picoteo. Mantén la estructura.';
  }

  Future<void> _saveHabits() async {
    final log = HabitsLogData(
      waterGlasses: _waterGlasses.round(),
      steps: _steps.round(),
      energy: _energy.round(),
      snackAnxiety: _snackAnxiety.round(),
      note: _noteController.text.trim(),
    );

    final summary = SavedHabitsSummary(
      waterGlasses: log.waterGlasses,
      steps: log.steps,
      energy: log.energy,
      snackAnxiety: log.snackAnxiety,
      savedAtText: DateTime.now().toLocal().toString(),
    );

    await LocalStorageService.saveLastHabits(summary);
    await LocalStorageService.saveHabitsToHistory(summary);

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HabitsSummaryScreen(
          data: widget.data,
          log: log,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agua y pasos'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Registro diario básico',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Estos datos ayudan a saber si tu cuerpo está preparado para progresar o si toca mantener el plan.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                SliderCard(
                  title: 'Vasos de agua',
                  value: _waterGlasses,
                  label: '${_waterGlasses.round()} vasos',
                  min: 0,
                  max: 12,
                  divisions: 12,
                  onChanged: (value) {
                    setState(() => _waterGlasses = value);
                  },
                ),
                InfoText(text: waterMessage),
                const SizedBox(height: 14),
                SliderCard(
                  title: 'Pasos de hoy',
                  value: _steps,
                  label: '${_steps.round()} pasos',
                  min: 1000,
                  max: 10000,
                  divisions: 18,
                  onChanged: (value) {
                    setState(() => _steps = value);
                  },
                ),
                InfoText(text: stepsMessage),
                const SizedBox(height: 14),
                SliderCard(
                  title: 'Energía del día',
                  value: _energy,
                  label: '${_energy.round()}/10',
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: (value) {
                    setState(() => _energy = value);
                  },
                ),
                InfoText(text: energyMessage),
                const SizedBox(height: 14),
                SliderCard(
                  title: 'Ansiedad por snacks',
                  value: _snackAnxiety,
                  label: '${_snackAnxiety.round()}/10',
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: (value) {
                    setState(() => _snackAnxiety = value);
                  },
                ),
                InfoText(text: snackMessage),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _noteController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Nota libre',
                    hintText:
                        'Ejemplo: he dormido mal, he tenido hambre a las 03:00, he caminado más de lo normal...',
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: _saveHabits,
                    child: const Text(
                      'Guardar registro diario',
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
