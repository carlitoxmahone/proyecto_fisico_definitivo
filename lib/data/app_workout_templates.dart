import '../models/exercise_alternative.dart';
import '../models/workout_exercise.dart';
import '../models/workout_template.dart';

class AppWorkoutTemplates {
  static const fullBodyA = WorkoutTemplate(
    name: 'Full body A',
    subtitle: 'Base técnica y fuerza general',
    focus:
        'Primer entrenamiento de la semana. Prioridad: técnica, control y empezar sin machacarte.',
    exercises: [
      WorkoutExercise(
        name: 'Prensa de piernas',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'Baja controlado, no bloquees las rodillas y mantén la espalda pegada al respaldo.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Sentadilla en multipower suave',
            reason: 'Si la prensa está ocupada.',
            techniqueNote:
                'Baja hasta donde controles bien. Mantén torso firme y rodillas estables.',
          ),
          ExerciseAlternative(
            name: 'Extensión de cuádriceps',
            reason: 'Si quieres una opción más sencilla y guiada.',
            techniqueNote:
                'Sube controlado y baja lento. No bloquees fuerte la rodilla.',
          ),
          ExerciseAlternative(
            name: 'Goblet squat con mancuerna',
            reason: 'Si no hay máquinas disponibles.',
            techniqueNote:
                'Sujeta la mancuerna cerca del pecho y baja con control.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Jalón al pecho',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'Lleva la barra hacia la parte alta del pecho, sin balancearte y juntando escápulas.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Jalón con agarre cómodo',
            reason: 'Si el agarre original molesta.',
            techniqueNote:
                'Usa un agarre que no moleste hombros. Baja controlado hacia el pecho.',
          ),
          ExerciseAlternative(
            name: 'Remo en máquina',
            reason: 'Si el jalón está ocupado.',
            techniqueNote:
                'Pecho alto, codos hacia atrás y sin encoger hombros.',
          ),
          ExerciseAlternative(
            name: 'Pullover en polea',
            reason: 'Si quieres una alternativa más suave.',
            techniqueNote:
                'Brazos casi estirados, baja controlado y nota la espalda.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Press de pecho en máquina',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'Empuja fuerte, controla la bajada y evita que los hombros se vayan hacia delante.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Press convergente en máquina',
            reason: 'Si la máquina principal está ocupada.',
            techniqueNote:
                'Empuja con control y mantén los hombros protegidos.',
          ),
          ExerciseAlternative(
            name: 'Press inclinado en máquina',
            reason: 'Si quieres variar el ángulo.',
            techniqueNote:
                'Rango cómodo y estable. No fuerces el hombro.',
          ),
          ExerciseAlternative(
            name: 'Aperturas en máquina',
            reason: 'Si el press molesta.',
            techniqueNote:
                'Hazlo suave, sin estirar demasiado el hombro atrás.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Remo sentado en polea',
        sets: '2',
        reps: '12',
        rest: '75 s',
        techniqueNote:
            'Tira con la espalda, no con el cuello. Pecho alto y movimiento limpio.',
        alternatives: [
          ExerciseAlternative(
            name: 'Remo en máquina con pecho apoyado',
            reason: 'Si quieres más estabilidad.',
            techniqueNote:
                'Apoya el pecho y tira con los codos sin encoger hombros.',
          ),
          ExerciseAlternative(
            name: 'Remo con mancuerna apoyado',
            reason: 'Si la polea está ocupada.',
            techniqueNote:
                'Apoya una mano, espalda neutra y tira sin girar el tronco.',
          ),
          ExerciseAlternative(
            name: 'Jalón cerrado',
            reason: 'Si no hay remos disponibles.',
            techniqueNote:
                'Baja con control y evita balancearte.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Elevaciones laterales',
        sets: '2',
        reps: '12-15',
        rest: '60 s',
        techniqueNote:
            'Sube hasta la línea del hombro, sin impulso y con peso moderado.',
        alternatives: [
          ExerciseAlternative(
            name: 'Elevaciones laterales en polea',
            reason: 'Si quieres más control.',
            techniqueNote:
                'Peso bajo, recorrido limpio y sin impulso.',
          ),
          ExerciseAlternative(
            name: 'Máquina de hombro lateral',
            reason: 'Si hay máquina disponible.',
            techniqueNote:
                'Ajusta el asiento y sube controlado.',
          ),
          ExerciseAlternative(
            name: 'Face pull suave',
            reason: 'Si las elevaciones molestan.',
            techniqueNote:
                'Tira hacia la cara con codos altos y sin dolor.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Plancha abdominal',
        sets: '2',
        reps: '20-30 s',
        rest: '60 s',
        techniqueNote:
            'Aprieta abdomen y glúteos. No hundas la zona lumbar.',
        alternatives: [
          ExerciseAlternative(
            name: 'Dead bug',
            reason: 'Si la plancha carga la lumbar.',
            techniqueNote:
                'Zona lumbar pegada al suelo. Movimiento lento y controlado.',
          ),
          ExerciseAlternative(
            name: 'Pallof press',
            reason: 'Si prefieres hacerlo de pie.',
            techniqueNote:
                'Resiste la rotación. Abdomen firme.',
          ),
          ExerciseAlternative(
            name: 'Crunch en máquina suave',
            reason: 'Si quieres opción guiada.',
            techniqueNote:
                'Recorrido corto y controlado, sin tirar del cuello.',
          ),
        ],
      ),
    ],
  );

  static const fullBodyB = WorkoutTemplate(
    name: 'Full body B',
    subtitle: 'Espalda, piernas y estabilidad',
    focus:
        'Segunda sesión de fuerza. Mantenemos cuerpo completo, pero cambiamos estímulos para no repetir exactamente lo mismo.',
    exercises: [
      WorkoutExercise(
        name: 'Sentadilla goblet o multipower suave',
        sets: '3',
        reps: '10',
        rest: '90 s',
        techniqueNote:
            'Baja hasta donde controles bien. Rodillas estables y torso firme.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Prensa de piernas',
            reason: 'Si prefieres opción guiada.',
            techniqueNote:
                'Espalda pegada al respaldo y rango cómodo.',
          ),
          ExerciseAlternative(
            name: 'Hack squat suave',
            reason: 'Si está disponible y te resulta cómoda.',
            techniqueNote:
                'No bajes más de lo que controles. Sin dolor de rodilla.',
          ),
          ExerciseAlternative(
            name: 'Extensión de cuádriceps',
            reason: 'Si necesitas algo más simple.',
            techniqueNote:
                'Subida controlada y bajada lenta.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Remo en máquina',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'Pecho apoyado si es posible. Tira con codos y evita encoger hombros.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Remo sentado en polea',
            reason: 'Si la máquina está ocupada.',
            techniqueNote:
                'Pecho alto y movimiento limpio.',
          ),
          ExerciseAlternative(
            name: 'Remo con mancuerna apoyado',
            reason: 'Si quieres trabajar unilateral.',
            techniqueNote:
                'Espalda neutra y codo hacia atrás.',
          ),
          ExerciseAlternative(
            name: 'Jalón al pecho',
            reason: 'Si no hay remo disponible.',
            techniqueNote:
                'Baja la barra hacia el pecho sin balanceo.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Press inclinado en máquina',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'Controla la bajada y no fuerces el hombro. Rango cómodo y estable.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Press de pecho en máquina',
            reason: 'Si el inclinado está ocupado.',
            techniqueNote:
                'Controla la bajada y mantén hombros atrás.',
          ),
          ExerciseAlternative(
            name: 'Press con mancuernas ligero',
            reason: 'Si no hay máquina disponible.',
            techniqueNote:
                'Usa poco peso y rango cómodo.',
          ),
          ExerciseAlternative(
            name: 'Aperturas en máquina',
            reason: 'Si el press molesta.',
            techniqueNote:
                'Movimiento suave, sin estirar demasiado atrás.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Curl femoral sentado o tumbado',
        sets: '2',
        reps: '12',
        rest: '75 s',
        techniqueNote:
            'Movimiento lento. Nota el trabajo en isquios, no en la zona lumbar.',
        alternatives: [
          ExerciseAlternative(
            name: 'Peso muerto rumano con mancuernas ligero',
            reason: 'Si el curl femoral está ocupado.',
            techniqueNote:
                'Cadera atrás, espalda neutra y mancuernas cerca del cuerpo.',
          ),
          ExerciseAlternative(
            name: 'Puente de glúteo',
            reason: 'Si necesitas opción sencilla.',
            techniqueNote:
                'Sube apretando glúteo y baja controlado.',
          ),
          ExerciseAlternative(
            name: 'Hip thrust en máquina',
            reason: 'Si hay máquina disponible.',
            techniqueNote:
                'Empuja con talones y no hiperextiendas lumbar.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Face pull en polea',
        sets: '2',
        reps: '12-15',
        rest: '60 s',
        techniqueNote:
            'Tira hacia la cara con codos altos. Ejercicio suave para hombro y postura.',
        alternatives: [
          ExerciseAlternative(
            name: 'Pájaros en máquina',
            reason: 'Si la polea está ocupada.',
            techniqueNote:
                'Movimiento controlado y sin cargar cuello.',
          ),
          ExerciseAlternative(
            name: 'Remo alto con cuerda suave',
            reason: 'Si quieres algo parecido.',
            techniqueNote:
                'Codos altos, peso bajo y sin dolor.',
          ),
          ExerciseAlternative(
            name: 'Elevaciones laterales suaves',
            reason: 'Si quieres trabajar hombro sin polea.',
            techniqueNote:
                'Peso moderado y sin impulso.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Dead bug',
        sets: '2',
        reps: '8-10 por lado',
        rest: '60 s',
        techniqueNote:
            'Zona lumbar pegada al suelo. Movimiento lento y controlado.',
        alternatives: [
          ExerciseAlternative(
            name: 'Plancha abdominal',
            reason: 'Si prefieres isométrico.',
            techniqueNote:
                'Abdomen y glúteos apretados. No hundas lumbar.',
          ),
          ExerciseAlternative(
            name: 'Pallof press',
            reason: 'Si prefieres hacerlo de pie.',
            techniqueNote:
                'Resiste la rotación y mantén abdomen firme.',
          ),
          ExerciseAlternative(
            name: 'Crunch en máquina suave',
            reason: 'Si quieres opción guiada.',
            techniqueNote:
                'Movimiento corto, controlado y sin tirar del cuello.',
          ),
        ],
      ),
    ],
  );

  static const fullBodyC = WorkoutTemplate(
    name: 'Full body C',
    subtitle: 'Cierre semanal y control de fatiga',
    focus:
        'Tercera sesión. Cerramos la semana con fuerza útil, técnica limpia y sin buscar el fallo.',
    exercises: [
      WorkoutExercise(
        name: 'Peso muerto rumano con mancuernas ligero',
        sets: '3',
        reps: '10',
        rest: '90 s',
        techniqueNote:
            'Cadera atrás, espalda neutra y mancuernas pegadas al cuerpo. Sin dolor lumbar.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Curl femoral sentado o tumbado',
            reason: 'Si el rumano molesta lumbar.',
            techniqueNote:
                'Movimiento lento y controlado. No levantes la cadera.',
          ),
          ExerciseAlternative(
            name: 'Hip thrust en máquina',
            reason: 'Si quieres opción más guiada.',
            techniqueNote:
                'Empuja con talones y evita hiperextender lumbar.',
          ),
          ExerciseAlternative(
            name: 'Puente de glúteo',
            reason: 'Si necesitas una alternativa sencilla.',
            techniqueNote:
                'Sube apretando glúteo y baja controlado.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Jalón agarre cómodo',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'Usa el agarre que no moleste hombros. Baja controlado hacia el pecho.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Jalón al pecho',
            reason: 'Si el agarre cómodo no está disponible.',
            techniqueNote:
                'Barra hacia la parte alta del pecho, sin balanceo.',
          ),
          ExerciseAlternative(
            name: 'Remo sentado en polea',
            reason: 'Si el jalón está ocupado.',
            techniqueNote:
                'Pecho alto y codos atrás.',
          ),
          ExerciseAlternative(
            name: 'Pullover en polea',
            reason: 'Si quieres opción más suave.',
            techniqueNote:
                'Brazos casi estirados y control total.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Press de pecho convergente o máquina',
        sets: '3',
        reps: '10-12',
        rest: '90 s',
        techniqueNote:
            'No busques máximo peso. Estabilidad, control y hombros protegidos.',
        exerciseRole: 'principal',
        alternatives: [
          ExerciseAlternative(
            name: 'Press de pecho en máquina',
            reason: 'Si la convergente está ocupada.',
            techniqueNote:
                'Empuja controlado y mantén escápulas estables.',
          ),
          ExerciseAlternative(
            name: 'Press inclinado en máquina',
            reason: 'Si quieres cambiar el ángulo.',
            techniqueNote:
                'Rango cómodo y sin dolor de hombro.',
          ),
          ExerciseAlternative(
            name: 'Aperturas en máquina',
            reason: 'Si el press molesta.',
            techniqueNote:
                'Movimiento suave y controlado.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Extensión de cuádriceps',
        sets: '2',
        reps: '12-15',
        rest: '75 s',
        techniqueNote:
            'Sube controlado y baja lento. No bloquees fuerte la rodilla.',
        alternatives: [
          ExerciseAlternative(
            name: 'Prensa de piernas ligera',
            reason: 'Si la extensión está ocupada.',
            techniqueNote:
                'Rango cómodo, sin bloquear rodillas.',
          ),
          ExerciseAlternative(
            name: 'Sentadilla goblet suave',
            reason: 'Si no hay máquinas disponibles.',
            techniqueNote:
                'Baja controlado y mantén torso firme.',
          ),
          ExerciseAlternative(
            name: 'Step-up bajo',
            reason: 'Si quieres opción sencilla.',
            techniqueNote:
                'Sube a una altura baja, controlando la rodilla.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Curl bíceps en polea o máquina',
        sets: '2',
        reps: '12',
        rest: '60 s',
        techniqueNote:
            'Codos quietos y recorrido limpio. Sin balanceo.',
        alternatives: [
          ExerciseAlternative(
            name: 'Curl bíceps con mancuernas',
            reason: 'Si la polea está ocupada.',
            techniqueNote:
                'Codos quietos y sin impulso.',
          ),
          ExerciseAlternative(
            name: 'Curl martillo',
            reason: 'Si quieres agarre más cómodo.',
            techniqueNote:
                'Palmas enfrentadas y movimiento controlado.',
          ),
          ExerciseAlternative(
            name: 'Curl en banco inclinado ligero',
            reason: 'Si quieres más control.',
            techniqueNote:
                'Peso bajo y recorrido limpio.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Press tríceps en polea',
        sets: '2',
        reps: '12',
        rest: '60 s',
        techniqueNote:
            'Codos pegados al cuerpo. Extiende sin bloquear agresivamente.',
        alternatives: [
          ExerciseAlternative(
            name: 'Extensión tríceps con cuerda',
            reason: 'Si quieres agarre más cómodo.',
            techniqueNote:
                'Codos quietos y abre la cuerda al final.',
          ),
          ExerciseAlternative(
            name: 'Fondos asistidos en máquina',
            reason: 'Si hay máquina y no molesta hombro.',
            techniqueNote:
                'Rango cómodo, sin bajar demasiado.',
          ),
          ExerciseAlternative(
            name: 'Extensión tríceps por encima de la cabeza en polea',
            reason: 'Si quieres cambiar el estímulo.',
            techniqueNote:
                'Peso bajo y codos estables.',
          ),
        ],
      ),
      WorkoutExercise(
        name: 'Pallof press',
        sets: '2',
        reps: '10 por lado',
        rest: '60 s',
        techniqueNote:
            'Resiste la rotación. Abdomen firme y respiración controlada.',
        alternatives: [
          ExerciseAlternative(
            name: 'Dead bug',
            reason: 'Si no hay polea disponible.',
            techniqueNote:
                'Zona lumbar pegada al suelo y movimiento lento.',
          ),
          ExerciseAlternative(
            name: 'Plancha abdominal',
            reason: 'Si prefieres isométrico.',
            techniqueNote:
                'Abdomen firme y sin hundir lumbar.',
          ),
          ExerciseAlternative(
            name: 'Crunch en máquina suave',
            reason: 'Si quieres opción guiada.',
            techniqueNote:
                'Controla el movimiento y evita tirar del cuello.',
          ),
        ],
      ),
    ],
  );
}
