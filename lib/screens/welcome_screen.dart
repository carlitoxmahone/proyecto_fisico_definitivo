import 'package:flutter/material.dart';

import 'assessment_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _accent = Color(0xFF00E0A4);
  static const _surface = Color(0xFF111821);

  void _goToAssessment(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AssessmentScreen(),
      ),
    );
  }

  void _showAccountComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('El acceso con cuenta estará disponible próximamente.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _surface,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _accent.withValues(alpha: 0.08),
                            blurRadius: 36,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: _accent.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: _accent.withValues(alpha: 0.22),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.fitness_center,
                                    color: _accent,
                                    size: 30,
                                  ),
                                ),
                                const _BetaLabel(),
                              ],
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              'Proyecto Físico Definitivo',
                              style: TextStyle(
                                fontSize: 34,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Tu entrenador personal inteligente',
                              style: TextStyle(
                                fontSize: 19,
                                height: 1.25,
                                fontWeight: FontWeight.w700,
                                color: _accent,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'Planifica, registra y analiza tus entrenamientos, '
                              'hábitos y progreso desde una sola app.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.45,
                                color: Colors.white.withValues(alpha: 0.76),
                              ),
                            ),
                            const SizedBox(height: 34),
                            SizedBox(
                              height: 56,
                              child: FilledButton.icon(
                                onPressed: () => _goToAssessment(context),
                                icon: const Icon(Icons.arrow_forward),
                                label: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Continuar en modo local',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 52,
                              child: OutlinedButton.icon(
                                onPressed: () => _showAccountComingSoon(context),
                                icon: const Icon(Icons.lock_outline),
                                label: const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Iniciar sesión / Crear cuenta',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      Colors.white.withValues(alpha: 0.88),
                                  side: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: Colors.white.withValues(alpha: 0.48),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Modo local: los datos se guardan solo en '
                                    'este dispositivo.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.35,
                                      color:
                                          Colors.white.withValues(alpha: 0.52),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BetaLabel extends StatelessWidget {
  const _BetaLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: WelcomeScreen._accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: WelcomeScreen._accent.withValues(alpha: 0.22),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 16,
            color: WelcomeScreen._accent,
          ),
          SizedBox(width: 6),
          Text(
            'Beta privada',
            style: TextStyle(
              color: WelcomeScreen._accent,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
