import 'package:albertoguaman/src/model/project.dart';

/// Mapeo herramienta → proyectos donde la usé (stack interactivo).
const Map<String, List<String>> skillToProjectTitles = {
  'Java': ['MDM · Mi Chance (experiencia)'],
  'Flutter': [
    'Tarot Pragmático - Calculadora de Arcanos',
    'Mi Negocio Listo',
  ],
  'Dart': [
    'Tarot Pragmático - Calculadora de Arcanos',
    'Mi Negocio Listo',
  ],
  'Firebase': [
    'Tarot Pragmático - Calculadora de Arcanos',
    'Mi Negocio Listo',
  ],
  'Git': [
    'Rapidito',
    'Mi Negocio Listo',
    'Streaming Ecuador - Distribuidores',
  ],
  'HTML': [
    'Streaming Ecuador',
    'Tatiana Jiménez Abogada',
    'EMAPASOSQ-EP',
  ],
  'CSS': [
    'Streaming Ecuador',
    'Tatiana Jiménez Abogada',
  ],
  'JavaScript': [
    'Streaming Ecuador',
    'Tarot Pragmático',
  ],
  'MySQL': [
    'Streaming Ecuador - Distribuidores',
    'Mi Negocio Listo',
  ],
  'PostgreSQL': ['Rapidito'],
  'MDM / gestión de equipos': ['MDM · Mi Chance (experiencia)'],
  'Helpdesk': ['MDM · Mi Chance (experiencia)'],
  'Soporte L1 / L2': ['MDM · Mi Chance (experiencia)'],
  'Incidencias': ['MDM · Mi Chance (experiencia)'],
  'Hardware / software': ['MDM · Mi Chance (experiencia)'],
  'WordPress': ['EMAPASOSQ-EP', 'Inox Hierro', 'Lars Tree Services'],
  'WooCommerce': ['Inox Hierro'],
  'Webflow': [],
  'VPS': ['Streaming Ecuador - Distribuidores', 'Rapidito'],
  'Cursor': ['Portafolio albertoguaman.com', 'Productos Tinguar'],
  'Claude (Anthropic)': ['Portafolio albertoguaman.com', 'Productos Tinguar'],
};

List<ProjectModel> projectsForSkill(String skillName) {
  final titles = skillToProjectTitles[skillName] ?? const <String>[];
  final fromCatalog = infoProjectModel
      .where((p) => titles.any((t) => p.title == t || t.contains(p.title)))
      .toList();
  return fromCatalog;
}

List<String> projectHintsForSkill(String skillName) {
  return skillToProjectTitles[skillName] ?? const [];
}
