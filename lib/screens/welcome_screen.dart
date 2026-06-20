import 'package:flutter/material.dart';

import 'assessment_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _goToAssessment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AssessmentScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.fitness_center,
                    size: 72,
                    color: Color(0xFF00E0A4),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Tu entrenador adaptativo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'No vamos a darte una rutina genérica.\n\n'
                    'Primero conoceremos tu cuerpo, tu horario, tu objetivo y tu punto de partida.\n\n'
                    'Después construiremos un plan que se adapte a ti.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () => _goToAssessment(context),
                      child: const Text(
                        'Empezar evaluación',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'MVP v0.2.7 — Historial simple de hábitos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
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
