import 'package:flutter/material.dart';

import '../models/training_profile.dart';
import '../services/local_storage_service.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/section_title.dart';

class TrainingProfileScreen extends StatefulWidget {
  const TrainingProfileScreen({
    super.key,
    required this.initialProfile,
  });

  final TrainingProfile initialProfile;

  @override
  State<TrainingProfileScreen> createState() => _TrainingProfileScreenState();
}

class _TrainingProfileScreenState extends State<TrainingProfileScreen> {
  late String _goal;
  late String _level;
  late String _priority;

  TrainingProfile get _profile {
    return TrainingProfile(
      goal: _goal,
      level: _level,
      priority: _priority,
    );
  }

  @override
  void initState() {
    super.initState();
    _goal = widget.initialProfile.goal;
    _level = widget.initialProfile.level;
    _priority = widget.initialProfile.priority;
  }

  Future<void> _saveProfile() async {
    await LocalStorageService.saveTrainingProfile(_profile);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil de entrenamiento guardado.'),
      ),
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de entrenamiento'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Perfil de entrenamiento',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Este perfil será la base del cerebro del entrenador antes de automatizar progresiones, cargas o rutinas.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                const SectionTitle(
                  icon: Icons.tune_outlined,
                  title: 'Preferencias actuales',
                ),
                const SizedBox(height: 12),
                _ProfileDropdown(
                  label: 'Objetivo de entrenamiento',
                  value: _goal,
                  values: TrainingProfile.goals,
                  onChanged: (value) => setState(() => _goal = value),
                ),
                const SizedBox(height: 14),
                _ProfileDropdown(
                  label: 'Nivel',
                  value: _level,
                  values: TrainingProfile.levels,
                  onChanged: (value) => setState(() => _level = value),
                ),
                const SizedBox(height: 14),
                _ProfileDropdown(
                  label: 'Prioridad principal',
                  value: _priority,
                  values: TrainingProfile.priorities,
                  onChanged: (value) => setState(() => _priority = value),
                ),
                const SizedBox(height: 18),
                DashboardCard(
                  icon: Icons.psychology_alt_outlined,
                  title: 'Enfoque actual recomendado',
                  description: profile.recommendedFocus,
                  chips: [
                    profile.goal,
                    profile.level,
                    profile.priority,
                  ],
                ),
                const SizedBox(height: 12),
                DashboardCard(
                  icon: Icons.account_tree_outlined,
                  title: 'Base para futuras decisiones',
                  description: profile.explanation,
                  chips: const [
                    'Perfil',
                    'Objetivo',
                    'Nivel',
                    'Adherencia',
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: _saveProfile,
                    child: const Text(
                      'Guardar perfil',
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

class _ProfileDropdown extends StatelessWidget {
  const _ProfileDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
      ),
      items: values
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        onChanged(value);
      },
    );
  }
}
