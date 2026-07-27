import 'package:flutter/material.dart';

/// IDs estables de sección (independientes del idioma de la UI).
abstract final class SectionId {
  static const about = 'about';
  static const projects = 'projects';
  static const publications = 'publications';
  static const experience = 'experience';
}

final Map<String, GlobalKey> sectionKeys = {
  SectionId.about: GlobalKey(),
  SectionId.projects: GlobalKey(),
  SectionId.publications: GlobalKey(),
  SectionId.experience: GlobalKey(),
};
