import 'package:flutter/material.dart';

import '../models/user_assessment_data.dart';
import '../widgets/section_title.dart';
import 'diagnosis_screen.dart';

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
    if (!_formKey.currentState!.validate()) return;

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

    if (number == null) return 'Introduce un número válido';
    if (number <= 0) return 'El número debe ser mayor que 0';

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
                  const SectionTitle(
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
                  const SectionTitle(
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
                  const SectionTitle(
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

