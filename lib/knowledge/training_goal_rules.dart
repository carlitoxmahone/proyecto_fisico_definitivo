class TrainingGoalRule {
  const TrainingGoalRule({
    required this.goal,
    required this.level,
    required this.priority,
    required this.mainRepRange,
    required this.accessoryRepRange,
    required this.loadFocus,
    required this.restRecommendation,
    required this.weeklyStructureHint,
    required this.progressionMethod,
    required this.safetyNotes,
    required this.sourceIds,
  });

  final String goal;
  final String level;
  final String priority;
  final String mainRepRange;
  final String accessoryRepRange;
  final String loadFocus;
  final String restRecommendation;
  final String weeklyStructureHint;
  final String progressionMethod;
  final String safetyNotes;
  final List<String> sourceIds;
}

const trainingGoalRules = [
  TrainingGoalRule(
    goal: 'Adaptación',
    level: 'Principiante',
    priority: 'técnica, adherencia y tolerancia al entrenamiento',
    mainRepRange: '10-15',
    accessoryRepRange: '12-20',
    loadFocus: 'carga suave/moderada',
    restRecommendation: 'descansos cómodos, normalmente 60-90 segundos',
    weeklyStructureHint:
        '2-3 sesiones sencillas de cuerpo completo con margen técnico',
    progressionMethod:
        'primero completar técnica y rango, después subir poco',
    safetyNotes: 'evitar llegar al fallo y no subir carga con dolor',
    sourceIds: [
      'acsm_progression_2009',
      'resistance_load_meta_2021',
    ],
  ),
  TrainingGoalRule(
    goal: 'Adaptación',
    level: 'Intermedio',
    priority: 'consolidar técnica y tolerancia a más volumen',
    mainRepRange: '8-15',
    accessoryRepRange: '12-20',
    loadFocus: 'carga moderada con ejecución estable',
    restRecommendation: '60-120 segundos según ejercicio',
    weeklyStructureHint: '3 sesiones con cambios seguros y control de fatiga',
    progressionMethod: 'subidas pequeñas al completar todas las repeticiones',
    safetyNotes: 'mantener repeticiones en reserva y vigilar molestias',
    sourceIds: [
      'acsm_progression_2009',
    ],
  ),
  TrainingGoalRule(
    goal: 'Adaptación',
    level: 'Avanzado',
    priority: 'bloque de descarga, técnica y recuperación activa',
    mainRepRange: '8-12',
    accessoryRepRange: '10-20',
    loadFocus: 'carga moderada, lejos del fallo',
    restRecommendation: 'descanso suficiente para técnica limpia',
    weeklyStructureHint: 'mantener frecuencia reduciendo agresividad',
    progressionMethod: 'no buscar récords durante el bloque adaptativo',
    safetyNotes: 'priorizar recuperación y control articular',
    sourceIds: [
      'acsm_progression_2009',
    ],
  ),
  TrainingGoalRule(
    goal: 'Hipertrofia',
    level: 'Principiante',
    priority: 'volumen efectivo básico y aprendizaje técnico',
    mainRepRange: '8-12',
    accessoryRepRange: '10-20',
    loadFocus: 'carga moderada',
    restRecommendation: '60-120 segundos',
    weeklyStructureHint: '3 sesiones de cuerpo completo con volumen moderado',
    progressionMethod: 'doble progresión sin sacrificar técnica',
    safetyNotes: 'evitar subir carga si hay dolor o técnica mala',
    sourceIds: [
      'resistance_load_meta_2017',
      'resistance_load_meta_2021',
    ],
  ),
  TrainingGoalRule(
    goal: 'Hipertrofia',
    level: 'Intermedio',
    priority: 'volumen efectivo y progresión controlada',
    mainRepRange: '8-12',
    accessoryRepRange: '10-20',
    loadFocus: 'carga moderada/moderada-alta',
    restRecommendation: '90-150 segundos en principales',
    weeklyStructureHint: '3-4 sesiones con volumen repartido',
    progressionMethod: 'doble progresión',
    safetyNotes: 'evitar subir carga si hay dolor o técnica mala',
    sourceIds: [
      'resistance_load_meta_2017',
      'schoenfeld_grgic_loading_2021',
    ],
  ),
  TrainingGoalRule(
    goal: 'Hipertrofia',
    level: 'Avanzado',
    priority: 'volumen específico, esfuerzo medido y recuperación',
    mainRepRange: '6-12',
    accessoryRepRange: '10-20',
    loadFocus: 'carga moderada-alta con control de fatiga',
    restRecommendation: 'descansos suficientes para sostener rendimiento',
    weeklyStructureHint: 'bloques con volumen planificado y ajustes por fatiga',
    progressionMethod: 'progresión por repeticiones, series o carga',
    safetyNotes: 'vigilar fatiga acumulada y técnica bajo esfuerzo',
    sourceIds: [
      'resistance_load_meta_2017',
      'schoenfeld_grgic_loading_2021',
    ],
  ),
  TrainingGoalRule(
    goal: 'Fuerza',
    level: 'Principiante',
    priority: 'patrones principales y técnica segura',
    mainRepRange: '5-6',
    accessoryRepRange: '6-12',
    loadFocus: 'carga moderada-alta controlada',
    restRecommendation: '90-180 segundos',
    weeklyStructureHint: 'practicar básicos sin agresividad inicial',
    progressionMethod: 'pequeñas subidas con buena técnica',
    safetyNotes: 'no usar como punto de partida agresivo para principiantes',
    sourceIds: [
      'acsm_progression_2009',
      'nsca_periodization_principles',
    ],
  ),
  TrainingGoalRule(
    goal: 'Fuerza',
    level: 'Intermedio',
    priority: 'patrones principales, cargas altas controladas y descanso',
    mainRepRange: '3-6',
    accessoryRepRange: '6-12',
    loadFocus: 'carga alta controlada',
    restRecommendation: '2-3 minutos en ejercicios principales',
    weeklyStructureHint: '3 sesiones con básicos y accesorios moderados',
    progressionMethod: 'pequeñas subidas con buena técnica',
    safetyNotes: 'no subir si aparece dolor o pérdida técnica',
    sourceIds: [
      'acsm_progression_2009',
      'nsca_periodization_principles',
    ],
  ),
  TrainingGoalRule(
    goal: 'Fuerza',
    level: 'Avanzado',
    priority: 'intensidad alta, especificidad y recuperación suficiente',
    mainRepRange: '1-5',
    accessoryRepRange: '5-10',
    loadFocus: 'carga alta con planificación conservadora',
    restRecommendation: '3 minutos o más si el rendimiento lo pide',
    weeklyStructureHint: 'bloques específicos con control de fatiga',
    progressionMethod: 'subidas pequeñas solo con ejecución estable',
    safetyNotes: 'no forzar máximos si hay dolor, fatiga o mala técnica',
    sourceIds: [
      'acsm_progression_2009',
    ],
  ),
  TrainingGoalRule(
    goal: 'Recomposición',
    level: 'Principiante',
    priority: 'fuerza base, volumen moderado, cardio suave y adherencia',
    mainRepRange: '8-12',
    accessoryRepRange: '10-15',
    loadFocus: 'carga moderada',
    restRecommendation: '60-120 segundos',
    weeklyStructureHint: '3 sesiones de fuerza y cardio suave',
    progressionMethod: 'conservadora, priorizando consistencia',
    safetyNotes: 'controlar fatiga, dolor y adherencia semanal',
    sourceIds: [
      'acsm_progression_2009',
      'resistance_load_meta_2021',
    ],
  ),
  TrainingGoalRule(
    goal: 'Recomposición',
    level: 'Intermedio',
    priority: 'mantener rendimiento mientras mejora la adherencia corporal',
    mainRepRange: '6-12',
    accessoryRepRange: '10-15',
    loadFocus: 'carga moderada',
    restRecommendation: '90-150 segundos',
    weeklyStructureHint: '3-4 sesiones con cardio suave y hábitos estables',
    progressionMethod: 'conservadora, priorizando consistencia',
    safetyNotes: 'controlar fatiga, dolor y adherencia semanal',
    sourceIds: [
      'acsm_progression_2009',
      'resistance_load_meta_2017',
    ],
  ),
  TrainingGoalRule(
    goal: 'Recomposición',
    level: 'Avanzado',
    priority: 'mantener rendimiento mientras se controla fatiga',
    mainRepRange: '5-10',
    accessoryRepRange: '8-15',
    loadFocus: 'carga moderada-alta según recuperación',
    restRecommendation: 'descansos suficientes para mantener calidad',
    weeklyStructureHint: 'bloques flexibles según energía, cardio y sueño',
    progressionMethod: 'muy conservadora si hay déficit o fatiga',
    safetyNotes: 'no perseguir progresión si cae la recuperación',
    sourceIds: [
      'acsm_progression_2009',
      'resistance_load_meta_2021',
    ],
  ),
];
