import 'package:flutter/material.dart';

/// IDs estables de sección (independientes del idioma de la UI).
abstract final class SectionId {
  static const about = 'about';
  static const experience = 'experience';
  static const skills = 'skills';
  static const clients = 'clients';
  static const gallery = 'gallery';
  static const projects = 'projects';
  static const publications = 'publications';
  static const content = 'content';
}

final Map<String, GlobalKey> sectionKeys = {
  SectionId.about: GlobalKey(),
  SectionId.experience: GlobalKey(),
  SectionId.skills: GlobalKey(),
  SectionId.clients: GlobalKey(),
  SectionId.gallery: GlobalKey(),
  SectionId.projects: GlobalKey(),
  SectionId.publications: GlobalKey(),
  SectionId.content: GlobalKey(),
};
