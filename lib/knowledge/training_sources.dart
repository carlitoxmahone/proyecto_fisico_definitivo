class TrainingSource {
  const TrainingSource({
    required this.id,
    required this.title,
    required this.authorsOrOrganization,
    required this.year,
    required this.note,
  });

  final String id;
  final String title;
  final String authorsOrOrganization;
  final int year;
  final String note;
}

const trainingSources = [
  TrainingSource(
    id: 'acsm_progression_2009',
    title:
        'Progression Models in Resistance Training for Healthy Adults',
    authorsOrOrganization: 'American College of Sports Medicine',
    year: 2009,
    note:
        'Referencia base para progresión, volumen, intensidad y descanso en entrenamiento de fuerza.',
  ),
  TrainingSource(
    id: 'schoenfeld_grgic_loading_2021',
    title:
        'Strength and hypertrophy adaptations between low- vs high-load resistance training',
    authorsOrOrganization: 'Schoenfeld, Grgic et al.',
    year: 2021,
    note:
        'Marcador interno para mantener trazabilidad de variables de entrenamiento actualizadas.',
  ),
  TrainingSource(
    id: 'resistance_load_meta_2017',
    title:
        'Resistance training load effects on muscle hypertrophy and strength',
    authorsOrOrganization: 'Schoenfeld et al.',
    year: 2017,
    note:
        'Base orientativa para diferenciar adaptaciones de fuerza e hipertrofia según cargas y rangos.',
  ),
  TrainingSource(
    id: 'resistance_load_meta_2021',
    title:
        'Low-load and high-load resistance training effects on hypertrophy and strength',
    authorsOrOrganization: 'Systematic review literature',
    year: 2021,
    note:
        'Referencia interna para rangos amplios de repeticiones, esfuerzo y seguridad técnica.',
  ),
  TrainingSource(
    id: 'nsca_periodization_principles',
    title: 'Periodization and program design principles',
    authorsOrOrganization: 'National Strength and Conditioning Association',
    year: 2021,
    note:
        'Referencia interna para progresión, estructura semanal y gestión de fatiga.',
  ),
];
