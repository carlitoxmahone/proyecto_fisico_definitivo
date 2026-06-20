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

class WorkoutLogData {
  const WorkoutLogData({
    required this.feeling,
    required this.difficulty,
    required this.hasPain,
    required this.painNote,
    required this.cardioCompleted,
    required this.freeNote,
  });

  final String feeling;
  final int difficulty;
  final bool hasPain;
  final String painNote;
  final bool cardioCompleted;
  final String freeNote;
}

class NutritionMeal {
  const NutritionMeal({
    required this.time,
    required this.title,
    required this.description,
    required this.goal,
  });

  final String time;
  final String title;
  final String description;
  final String goal;
}

class HabitsLogData {
  const HabitsLogData({
    required this.waterGlasses,
    required this.steps,
    required this.energy,
    required this.snackAnxiety,
    required this.note,
  });

  final int waterGlasses;
  final int steps;
  final int energy;
  final int snackAnxiety;
  final String note;
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
                    'MVP v0.1.8 — Registro de agua y pasos',
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
                _ActionTile(
                  icon: Icons.fitness_center_outlined,
                  title: 'Ver entrenamiento de hoy',
                  subtitle: 'Pantalla de sesión diaria disponible.',
                  onTap: () => _goToWorkoutToday(context),
                ),
                _ActionTile(
                  icon: Icons.restaurant_outlined,
                  title: 'Ver comidas recomendadas',
                  subtitle: 'Nutrición adaptada a tu horario nocturno.',
                  onTap: () => _goToNutrition(context),
                ),
                _ActionTile(
                  icon: Icons.water_drop_outlined,
                  title: 'Registrar agua y pasos',
                  subtitle: 'Registro básico de hábitos diarios.',
                  onTap: () => _goToHabits(context),
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
                _NutritionModeCard(
                  trainingDay: _trainingDay,
                  onChanged: (value) {
                    setState(() => _trainingDay = value);
                  },
                ),
                const SizedBox(height: 22),
                const _SectionTitle(
                  icon: Icons.restaurant_outlined,
                  title: 'Comidas recomendadas',
                ),
                const SizedBox(height: 12),
                ...meals.asMap().entries.map(
                      (entry) => _NutritionMealCard(
                        number: entry.key + 1,
                        meal: entry.value,
                      ),
                    ),
                const SizedBox(height: 18),
                const _DashboardCard(
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
                const _DashboardCard(
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
                const _DashboardCard(
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

  void _saveHabits() {
    final log = HabitsLogData(
      waterGlasses: _waterGlasses.round(),
      steps: _steps.round(),
      energy: _energy.round(),
      snackAnxiety: _snackAnxiety.round(),
      note: _noteController.text.trim(),
    );

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
                _SliderCard(
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
                _InfoText(text: waterMessage),
                const SizedBox(height: 14),
                _SliderCard(
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
                _InfoText(text: stepsMessage),
                const SizedBox(height: 14),
                _SliderCard(
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
                _InfoText(text: energyMessage),
                const SizedBox(height: 14),
                _SliderCard(
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
                _InfoText(text: snackMessage),
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

class HabitsSummaryScreen extends StatelessWidget {
  const HabitsSummaryScreen({
    super.key,
    required this.data,
    required this.log,
  });

  final UserAssessmentData data;
  final HabitsLogData log;

  String get recommendation {
    if (log.energy <= 3) {
      return 'Mañana conviene mantener una sesión suave o mínima. La energía está baja.';
    }

    if (log.snackAnxiety >= 8) {
      return 'Hay que reforzar la comida del descanso y tener una opción prevista anti-snacks.';
    }

    if (log.steps < 2500) {
      return 'Mañana el objetivo será sumar algo más de movimiento sin forzar.';
    }

    return 'Buen registro. Mantén estructura y constancia antes de subir exigencia.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro guardado'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF00E0A4),
                  size: 64,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Registro diario guardado',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'De momento se guarda solo en memoria. Más adelante lo guardaremos de forma persistente.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                _DiagnosisCard(
                  icon: Icons.water_drop_outlined,
                  title: 'Hábitos registrados',
                  lines: [
                    'Agua: ${log.waterGlasses} vasos',
                    'Pasos: ${log.steps}',
                    'Energía: ${log.energy}/10',
                    'Ansiedad por snacks: ${log.snackAnxiety}/10',
                    if (log.note.isNotEmpty) 'Nota: ${log.note}',
                  ],
                ),
                _DiagnosisCard(
                  icon: Icons.psychology_alt_outlined,
                  title: 'Primera decisión adaptativa',
                  lines: [
                    recommendation,
                    'Estos datos se usarán después para ajustar entrenamiento, cardio y nutrición.',
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => DashboardScreen(data: data),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Volver al panel principal',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutTodayScreen extends StatefulWidget {
  const WorkoutTodayScreen({
    super.key,
    required this.data,
  });

  final UserAssessmentData data;

  @override
  State<WorkoutTodayScreen> createState() => _WorkoutTodayScreenState();
}

class _WorkoutTodayScreenState extends State<WorkoutTodayScreen> {
  final _logFormKey = GlobalKey<FormState>();

  String _feeling = 'Normal';
  double _difficulty = 5;
  bool _hasPain = false;
  bool _cardioCompleted = false;

  final _painNoteController = TextEditingController();
  final _freeNoteController = TextEditingController();

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

  @override
  void dispose() {
    _painNoteController.dispose();
    _freeNoteController.dispose();
    super.dispose();
  }

  void _completeWorkout() {
    if (!_logFormKey.currentState!.validate()) {
      return;
    }

    final log = WorkoutLogData(
      feeling: _feeling,
      difficulty: _difficulty.round(),
      hasPain: _hasPain,
      painNote: _painNoteController.text.trim(),
      cardioCompleted: _cardioCompleted,
      freeNote: _freeNoteController.text.trim(),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutCompletedScreen(
          data: widget.data,
          log: log,
        ),
      ),
    );
  }

  String? _painValidator(String? value) {
    if (!_hasPain) return null;

    if (value == null || value.trim().isEmpty) {
      return 'Indica dónde has notado la molestia';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final hasNightShiftText =
        widget.data.hasNightShift ? 'Post-turno nocturno' : 'Horario estándar';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamiento de hoy'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: Form(
              key: _logFormKey,
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
                    goal: widget.data.currentGoal,
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
                  const SizedBox(height: 24),
                  const _SectionTitle(
                    icon: Icons.edit_note_outlined,
                    title: 'Registro del entrenamiento',
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _feeling,
                    decoration: const InputDecoration(
                      labelText: 'Sensación general',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Muy mal',
                        child: Text('Muy mal'),
                      ),
                      DropdownMenuItem(
                        value: 'Cansado',
                        child: Text('Cansado'),
                      ),
                      DropdownMenuItem(
                        value: 'Normal',
                        child: Text('Normal'),
                      ),
                      DropdownMenuItem(
                        value: 'Bien',
                        child: Text('Bien'),
                      ),
                      DropdownMenuItem(
                        value: 'Muy bien',
                        child: Text('Muy bien'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _feeling = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  _SliderCard(
                    title: 'Dificultad percibida',
                    value: _difficulty,
                    label: '${_difficulty.round()}/10',
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() => _difficulty = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    value: _cardioCompleted,
                    activeThumbColor: const Color(0xFF00E0A4),
                    title: const Text(
                      'He completado el cardio suave',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      'Caminar 15-20 minutos después de la fuerza.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() => _cardioCompleted = value);
                    },
                  ),
                  SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    value: _hasPain,
                    activeThumbColor: const Color(0xFFFFC857),
                    title: const Text(
                      'He notado dolor o molestia',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      'Esto servirá para adaptar ejercicios en próximas versiones.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() => _hasPain = value);
                    },
                  ),
                  if (_hasPain) ...[
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _painNoteController,
                      validator: _painValidator,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Dónde has notado la molestia',
                        hintText: 'Ejemplo: hombro derecho en press de pecho',
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _freeNoteController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Nota libre',
                      hintText:
                          'Ejemplo: fui cansado, pero terminé todo con buena técnica.',
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: _completeWorkout,
                      child: const Text(
                        'Completar y ver resumen',
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
      ),
    );
  }
}

class WorkoutCompletedScreen extends StatelessWidget {
  const WorkoutCompletedScreen({
    super.key,
    required this.data,
    required this.log,
  });

  final UserAssessmentData data;
  final WorkoutLogData log;

  String get recommendation {
    if (log.hasPain) {
      return 'Próxima recomendación: revisar el ejercicio donde hubo molestia y preparar una alternativa segura.';
    }

    if (log.difficulty >= 8) {
      return 'Próxima recomendación: mantener el mismo nivel. No subimos carga todavía porque la sesión fue dura.';
    }

    if (log.difficulty <= 4 && log.feeling == 'Muy bien') {
      return 'Próxima recomendación: podríamos subir ligeramente la exigencia si se repite esta sensación.';
    }

    return 'Próxima recomendación: repetir estructura y buscar constancia antes de aumentar volumen.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamiento completado'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF00E0A4),
                  size: 64,
                ),
                const SizedBox(height: 18),
                Text(
                  'Buen trabajo, ${data.name}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Este registro será la base para que la app aprenda de tu recuperación, molestias y adherencia.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                _DiagnosisCard(
                  icon: Icons.edit_note_outlined,
                  title: 'Resumen registrado',
                  lines: [
                    'Sensación general: ${log.feeling}',
                    'Dificultad percibida: ${log.difficulty}/10',
                    log.cardioCompleted
                        ? 'Cardio suave completado.'
                        : 'Cardio suave no completado.',
                    log.hasPain
                        ? 'Molestia registrada: ${log.painNote}'
                        : 'Sin dolor o molestia registrada.',
                    if (log.freeNote.isNotEmpty) 'Nota: ${log.freeNote}',
                  ],
                ),
                _DiagnosisCard(
                  icon: Icons.psychology_alt_outlined,
                  title: 'Primera decisión adaptativa',
                  lines: [
                    recommendation,
                    'En próximas versiones este resultado modificará automáticamente el plan.',
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => DashboardScreen(data: data),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Volver al panel principal',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NutritionModeCard extends StatelessWidget {
  const _NutritionModeCard({
    required this.trainingDay,
    required this.onChanged,
  });

  final bool trainingDay;
  final ValueChanged<bool> onChanged;

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
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tipo de día',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  label: Text('Entreno'),
                  icon: Icon(Icons.fitness_center_outlined),
                ),
                ButtonSegment(
                  value: false,
                  label: Text('Descanso'),
                  icon: Icon(Icons.bedtime_outlined),
                ),
              ],
              selected: {trainingDay},
              onSelectionChanged: (selection) {
                onChanged(selection.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NutritionMealCard extends StatelessWidget {
  const _NutritionMealCard({
    required this.number,
    required this.meal,
  });

  final int number;
  final NutritionMeal meal;

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
                    meal.time,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    meal.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.description,
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.38,
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _SmallChip(label: meal.goal),
                ],
              ),
            ),
          ],
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

class _SliderCard extends StatelessWidget {
  const _SliderCard({
    required this.title,
    required this.value,
    required this.label,
    required this.onChanged,
    required this.min,
    required this.max,
    required this.divisions,
  });

  final String title;
  final double value;
  final String label;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final int divisions;

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
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title: $label',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
            Slider(
              min: min,
              max: max,
              divisions: divisions,
              value: value,
              label: label,
              onChanged: onChanged,
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
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

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
        onTap: onTap ??
            () {
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

class _InfoText extends StatelessWidget {
  const _InfoText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          height: 1.35,
          color: Colors.white.withValues(alpha: 0.62),
        ),
      ),
    );
  }
}