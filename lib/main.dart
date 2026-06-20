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
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF121821),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF00E0A4),
              width: 1.6,
            ),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class UserAssessmentData {
  const UserAssessmentData({
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.waistCm,
    required this.currentGoal,
    required this.visualGoal,
    required this.trainingDays,
    required this.hasNightShift,
  });

  final String name;
  final String age;
  final String heightCm;
  final String weightKg;
  final String waistCm;
  final String currentGoal;
  final String visualGoal;
  final String trainingDays;
  final bool hasNightShift;
}

class WorkoutExercise {
  const WorkoutExercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.techniqueNote,
  });

  final String name;
  final String sets;
  final String reps;
  final String rest;
  final String techniqueNote;
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
                    'MVP v0.1.5 — Entrenamiento de hoy',
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

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController(text: 'Carlos');
  final _ageController = TextEditingController(text: '35');
  final _heightController = TextEditingController(text: '170');
  final _weightController = TextEditingController(text: '87');
  final _waistController = TextEditingController(text: '108');
  final _trainingDaysController = TextEditingController(text: '5');

  String _currentGoal = 'Recomposición corporal';
  String _visualGoal = 'Grande y musculoso';
  bool _hasNightShift = true;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _trainingDaysController.dispose();
    super.dispose();
  }

  void _generateDiagnosis() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final data = UserAssessmentData(
      name: _nameController.text.trim(),
      age: _ageController.text.trim(),
      heightCm: _heightController.text.trim(),
      weightKg: _weightController.text.trim(),
      waistCm: _waistController.text.trim(),
      currentGoal: _currentGoal,
      visualGoal: _visualGoal,
      trainingDays: _trainingDaysController.text.trim(),
      hasNightShift: _hasNightShift,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DiagnosisScreen(data: data),
      ),
    );
  }

  String? _requiredNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este dato es obligatorio';
    }

    final number = num.tryParse(value.replaceAll(',', '.'));

    if (number == null) {
      return 'Introduce un número válido';
    }

    if (number <= 0) {
      return 'El número debe ser mayor que 0';
    }

    return null;
  }

  String? _requiredTextValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este dato es obligatorio';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación inicial'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const Text(
                    'Datos básicos',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Esta primera versión recoge los datos mínimos para generar un diagnóstico inicial. Más adelante dividiremos la evaluación en varias pantallas.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SectionTitle(
                    icon: Icons.person_outline,
                    title: 'Perfil físico',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameController,
                    validator: _requiredTextValidator,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Ejemplo: Carlos',
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ageController,
                          validator: _requiredNumberValidator,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Edad',
                            suffixText: 'años',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _heightController,
                          validator: _requiredNumberValidator,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Altura',
                            suffixText: 'cm',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          validator: _requiredNumberValidator,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Peso actual',
                            suffixText: 'kg',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _waistController,
                          validator: _requiredNumberValidator,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Cintura',
                            suffixText: 'cm',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const _SectionTitle(
                    icon: Icons.flag_outlined,
                    title: 'Objetivo',
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _currentGoal,
                    decoration: const InputDecoration(
                      labelText: 'Objetivo actual',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Perder grasa',
                        child: Text('Perder grasa'),
                      ),
                      DropdownMenuItem(
                        value: 'Ganar músculo',
                        child: Text('Ganar músculo'),
                      ),
                      DropdownMenuItem(
                        value: 'Recomposición corporal',
                        child: Text('Recomposición corporal'),
                      ),
                      DropdownMenuItem(
                        value: 'Ganar fuerza',
                        child: Text('Ganar fuerza'),
                      ),
                      DropdownMenuItem(
                        value: 'Mejorar salud y forma física',
                        child: Text('Mejorar salud y forma física'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _currentGoal = value);
                    },
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<String>(
                    value: _visualGoal,
                    decoration: const InputDecoration(
                      labelText: 'Objetivo visual',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Atlético y definido',
                        child: Text('Atlético y definido'),
                      ),
                      DropdownMenuItem(
                        value: 'Grande y musculoso',
                        child: Text('Grande y musculoso'),
                      ),
                      DropdownMenuItem(
                        value: 'Delgado y marcado',
                        child: Text('Delgado y marcado'),
                      ),
                      DropdownMenuItem(
                        value: 'Fuerte, ancho y compacto',
                        child: Text('Fuerte, ancho y compacto'),
                      ),
                      DropdownMenuItem(
                        value: 'Equilibrado, sano y estético',
                        child: Text('Equilibrado, sano y estético'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _visualGoal = value);
                    },
                  ),
                  const SizedBox(height: 28),
                  const _SectionTitle(
                    icon: Icons.fitness_center_outlined,
                    title: 'Entrenamiento y horario',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _trainingDaysController,
                    validator: _requiredNumberValidator,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Días reales disponibles por semana',
                      suffixText: 'días',
                    ),
                  ),
                  const SizedBox(height: 14),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    value: _hasNightShift,
                    activeThumbColor: const Color(0xFF00E0A4),
                    title: const Text(
                      'Trabajo en turno nocturno',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Activa el modo de comidas, entrenamiento y recuperación adaptado a la noche.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() => _hasNightShift = value);
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: _generateDiagnosis,
                      child: const Text(
                        'Generar diagnóstico',
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
                _DiagnosisCard(
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
                _DiagnosisCard(
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
                _DiagnosisCard(
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
                _DiagnosisCard(
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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  void _goToWorkoutToday(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutTodayScreen(data: data),
      ),
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
                  'Tu plan inicial ya está preparado. Esta es la primera versión del panel principal.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                _MainStatusCard(data: data),
                const SizedBox(height: 18),
                const _SectionTitle(
                  icon: Icons.route_outlined,
                  title: 'Fase actual',
                ),
                const SizedBox(height: 12),
                _DashboardCard(
                  icon: Icons.rocket_launch_outlined,
                  title: 'Adaptación inteligente — 4 semanas',
                  description:
                      'No empezamos con 5 días duros. Primero construimos adherencia, técnica, fuerza base y tolerancia al cardio.',
                  chips: [
                    '$recommendedStrengthDays días fuerza',
                    if (optionalDay) '1 día opcional',
                    'Cardio suave',
                    'Pasos progresivos',
                  ],
                ),
                const SizedBox(height: 18),
                const _SectionTitle(
                  icon: Icons.today_outlined,
                  title: 'Acciones de hoy',
                ),
                const SizedBox(height: 12),
                const _ActionTile(
                  icon: Icons.fitness_center_outlined,
                  title: 'Ver entrenamiento de hoy',
                  subtitle: 'Pantalla de sesión diaria disponible.',
                ),
                const _ActionTile(
                  icon: Icons.restaurant_outlined,
                  title: 'Ver comidas recomendadas',
                  subtitle: 'Próxima versión: nutrición por horario nocturno.',
                ),
                const _ActionTile(
                  icon: Icons.water_drop_outlined,
                  title: 'Registrar agua y pasos',
                  subtitle: 'Próxima versión: hábitos diarios básicos.',
                ),
                const SizedBox(height: 18),
                const _SectionTitle(
                  icon: Icons.insights_outlined,
                  title: 'Métricas iniciales',
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _MetricBox(
                      label: 'Peso',
                      value: '${data.weightKg} kg',
                    ),
                    _MetricBox(
                      label: 'Cintura',
                      value: '${data.waistCm} cm',
                    ),
                    _MetricBox(
                      label: 'Objetivo',
                      value: data.currentGoal,
                    ),
                    _MetricBox(
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
                    onPressed: () => _goToWorkoutToday(context),
                    child: const Text(
                      'Continuar con mi plan',
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

class WorkoutTodayScreen extends StatelessWidget {
  const WorkoutTodayScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  List<WorkoutExercise> get exercises => const [
        WorkoutExercise(
          name: 'Prensa de piernas',
          sets: '3',
          reps: '10-12',
          rest: '90 s',
          techniqueNote:
              'Baja controlado, no bloquees las rodillas y mantén la espalda pegada al respaldo.',
        ),
        WorkoutExercise(
          name: 'Jalón al pecho',
          sets: '3',
          reps: '10-12',
          rest: '90 s',
          techniqueNote:
              'Lleva la barra hacia la parte alta del pecho, sin balancearte y juntando escápulas.',
        ),
        WorkoutExercise(
          name: 'Press de pecho en máquina',
          sets: '3',
          reps: '10-12',
          rest: '90 s',
          techniqueNote:
              'Empuja fuerte, controla la bajada y evita que los hombros se vayan hacia delante.',
        ),
        WorkoutExercise(
          name: 'Remo sentado en polea',
          sets: '2',
          reps: '12',
          rest: '75 s',
          techniqueNote:
              'Tira con la espalda, no con el cuello. Pecho alto y movimiento limpio.',
        ),
        WorkoutExercise(
          name: 'Elevaciones laterales',
          sets: '2',
          reps: '12-15',
          rest: '60 s',
          techniqueNote:
              'Sube hasta la línea del hombro, sin impulso y con peso moderado.',
        ),
        WorkoutExercise(
          name: 'Plancha abdominal',
          sets: '2',
          reps: '20-30 s',
          rest: '60 s',
          techniqueNote:
              'Aprieta abdomen y glúteos. No hundas la zona lumbar.',
        ),
      ];

  void _completeWorkout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Entrenamiento marcado como completado. Próxima versión: guardar progreso real.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNightShiftText =
        data.hasNightShift ? 'Post-turno nocturno' : 'Horario estándar';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamiento de hoy'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Full body estratégico',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fase: Adaptación inteligente. Hoy no buscamos machacarte: buscamos técnica, constancia y una base sólida.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 22),
                _WorkoutSummaryCard(
                  goal: data.currentGoal,
                  schedule: hasNightShiftText,
                ),
                const SizedBox(height: 22),
                const _SectionTitle(
                  icon: Icons.fitness_center_outlined,
                  title: 'Ejercicios',
                ),
                const SizedBox(height: 12),
                ...exercises.asMap().entries.map(
                      (entry) => _ExerciseCard(
                        number: entry.key + 1,
                        exercise: entry.value,
                      ),
                    ),
                const SizedBox(height: 18),
                const _DashboardCard(
                  icon: Icons.directions_walk_outlined,
                  title: 'Cardio suave',
                  description:
                      'Después de la fuerza: caminar 15-20 minutos a ritmo cómodo. La prioridad es crear hábito sin reventarte.',
                  chips: [
                    '15-20 min',
                    'Ritmo cómodo',
                    'Sin impacto',
                  ],
                ),
                const SizedBox(height: 18),
                const _DashboardCard(
                  icon: Icons.warning_amber_outlined,
                  title: 'Regla de seguridad',
                  description:
                      'Si aparece dolor articular raro, mareo, pinchazo fuerte o molestia que cambia tu técnica, paras el ejercicio y lo registramos para adaptarlo.',
                  chips: [
                    'Sin ego',
                    'Técnica primero',
                    'Progresión gradual',
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () => _completeWorkout(context),
                    child: const Text(
                      'Marcar entrenamiento como completado',
                      style: TextStyle(
                        fontSize: 16,
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

class _WorkoutSummaryCard extends StatelessWidget {
  const _WorkoutSummaryCard({
    required this.goal,
    required this.schedule,
  });

  final String goal;
  final String schedule;

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
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SummaryPill(
              icon: Icons.flag_outlined,
              label: 'Objetivo',
              value: goal,
            ),
            _SummaryPill(
              icon: Icons.schedule_outlined,
              label: 'Horario',
              value: schedule,
            ),
            const _SummaryPill(
              icon: Icons.timer_outlined,
              label: 'Duración',
              value: '60-75 min',
            ),
            const _SummaryPill(
              icon: Icons.speed_outlined,
              label: 'Intensidad',
              value: 'Moderada',
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.number,
    required this.exercise,
  });

  final int number;
  final WorkoutExercise exercise;

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
            CircleAvatar(
              backgroundColor:
                  const Color(0xFF00E0A4).withValues(alpha: 0.16),
              foregroundColor: const Color(0xFF00E0A4),
              child: Text(
                '$number',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _SmallChip(label: '${exercise.sets} series'),
                      _SmallChip(label: '${exercise.reps} reps'),
                      _SmallChip(label: 'Descanso ${exercise.rest}'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    exercise.techniqueNote,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.38,
                      color: Colors.white.withValues(alpha: 0.70),
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

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF00E0A4),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MainStatusCard extends StatelessWidget {
  const _MainStatusCard({
    required this.data,
  });

  final UserAssessmentData data;

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
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF00E0A4),
              size: 38,
            ),
            const SizedBox(height: 14),
            const Text(
              'Plan inicial creado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Objetivo: ${data.currentGoal}. Enfoque visual: ${data.visualGoal}.',
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.76),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF00E0A4),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _DiagnosisCard extends StatelessWidget {
  const _DiagnosisCard({
    required this.icon,
    required this.title,
    required this.lines,
  });

  final IconData icon;
  final String title;
  final List<String> lines;

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
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...lines.map(
                    (line) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        '• $line',
                        style: TextStyle(
                          fontSize: 14.5,
                          height: 1.35,
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
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

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.chips,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> chips;

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
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.72),
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: chips
                  .map(
                    (chip) => Chip(
                      label: Text(chip),
                      backgroundColor:
                          const Color(0xFF00E0A4).withValues(alpha: 0.12),
                      side: BorderSide(
                        color: const Color(0xFF00E0A4)
                            .withValues(alpha: 0.18),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF00E0A4),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.62),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(subtitle),
            ),
          );
        },
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  const _MetricBox({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
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
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallChip extends StatelessWidget {
  const _SmallChip({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFF00E0A4).withValues(alpha: 0.10),
      side: BorderSide(
        color: const Color(0xFF00E0A4).withValues(alpha: 0.16),
      ),
    );
  }
}