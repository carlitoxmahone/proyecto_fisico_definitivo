import 'package:flutter/material.dart';

import '../models/workout_exercise.dart';
import 'small_chip.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    required this.number,
    required this.exercise,
    required this.kgControllers,
    required this.repsControllers,
    required this.onReplace,
  });

  final int number;
  final WorkoutExercise exercise;
  final List<TextEditingController> kgControllers;
  final List<TextEditingController> repsControllers;
  final VoidCallback onReplace;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: const Color(0xFF121821),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: exercise.wasReplaced
              ? const Color(0xFFFFC857).withValues(alpha: 0.35)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: exercise.wasReplaced
                  ? const Color(0xFFFFC857).withValues(alpha: 0.16)
                  : const Color(0xFF00E0A4).withValues(alpha: 0.16),
              foregroundColor: exercise.wasReplaced
                  ? const Color(0xFFFFC857)
                  : const Color(0xFF00E0A4),
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
                  if (exercise.wasReplaced && exercise.originalName != null) ...[
                    Text(
                      'Cambiado desde: ${exercise.originalName}',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: const Color(0xFFFFC857)
                            .withValues(alpha: 0.85),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
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
                      SmallChip(label: '${exercise.sets} series'),
                      SmallChip(label: '${exercise.reps} reps'),
                      SmallChip(label: 'Descanso ${exercise.rest}'),
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
                  const SizedBox(height: 14),
                  ...List.generate(
                    kgControllers.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 72,
                            child: Text(
                              'Serie ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: kgControllers[index],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'kg',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: repsControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'reps',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: onReplace,
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Cambiar ejercicio'),
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
