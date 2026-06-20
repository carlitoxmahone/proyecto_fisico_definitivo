import 'package:flutter/material.dart';

void main() {
  runApp(const ProyectoFisicoApp());
}

class ProyectoFisicoApp extends StatelessWidget {
  const ProyectoFisicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Físico Definitivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00E0A4),
          brightness: Brightness.dark,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    'MVP v0.1.2 — Navegación inicial',
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

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación inicial'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Vamos a conocerte antes de crear tu plan',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Esta evaluación servirá para construir tu perfil físico, tu objetivo, tu horario, tu nivel de entrenamiento y tu estrategia inicial.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const AssessmentInfoCard(
                    icon: Icons.monitor_weight_outlined,
                    title: 'Datos físicos',
                    description:
                        'Altura, peso, cintura y punto de partida real.',
                  ),
                  const AssessmentInfoCard(
                    icon: Icons.flag_outlined,
                    title: 'Objetivo',
                    description:
                        'Recomposición, fuerza, cardio, estética y prioridades.',
                  ),
                  const AssessmentInfoCard(
                    icon: Icons.schedule_outlined,
                    title: 'Horario real',
                    description:
                        'Turno nocturno, sueño, entrenamiento y comidas.',
                  ),
                  const AssessmentInfoCard(
                    icon: Icons.fitness_center_outlined,
                    title: 'Entrenamiento',
                    description:
                        'Disponibilidad, gimnasio, nivel y fatiga actual.',
                  ),
                  const AssessmentInfoCard(
                    icon: Icons.restaurant_outlined,
                    title: 'Nutrición',
                    description:
                        'Comidas, agua, proteína, snacks y método de control.',
                  ),
                  const AssessmentInfoCard(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Seguridad',
                    description:
                        'Dolores, lesiones, limitaciones y señales de alarma.',
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Siguiente versión: formulario real de evaluación',
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Volver'),
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

class AssessmentInfoCard extends StatelessWidget {
  const AssessmentInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: const Color(0xFF00E0A4),
              size: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.35,
                      color: Colors.white.withValues(alpha: 0.68),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}