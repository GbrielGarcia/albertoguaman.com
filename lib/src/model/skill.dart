import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillItem {
  final String name;
  final FaIconData icon;

  const SkillItem({
    required this.name,
    required this.icon,
  });
}

class SkillGroup {
  final String title;
  final String subtitle;
  final List<SkillItem> items;

  const SkillGroup({
    required this.title,
    required this.subtitle,
    required this.items,
  });
}

/// Herramientas y tecnologías que uso en el día a día.
const List<SkillGroup> infoSkillGroups = [
  SkillGroup(
    title: 'Desarrollo',
    subtitle: 'Apps, web y datos',
    items: [
      SkillItem(name: 'Java', icon: FontAwesomeIcons.java),
      SkillItem(name: 'Flutter', icon: FontAwesomeIcons.flutter),
      SkillItem(name: 'Dart', icon: FontAwesomeIcons.code),
      SkillItem(name: 'Firebase', icon: FontAwesomeIcons.fire),
      SkillItem(name: 'Git', icon: FontAwesomeIcons.gitAlt),
      SkillItem(name: 'HTML', icon: FontAwesomeIcons.html5),
      SkillItem(name: 'CSS', icon: FontAwesomeIcons.css3Alt),
      SkillItem(name: 'JavaScript', icon: FontAwesomeIcons.js),
      SkillItem(name: 'MySQL', icon: FontAwesomeIcons.database),
      SkillItem(name: 'PostgreSQL', icon: FontAwesomeIcons.database),
    ],
  ),
  SkillGroup(
    title: 'Soporte / IT',
    subtitle: 'Helpdesk y operación técnica',
    items: [
      SkillItem(
          name: 'MDM / gestión de equipos',
          icon: FontAwesomeIcons.mobileScreen),
      SkillItem(name: 'Helpdesk', icon: FontAwesomeIcons.headset),
      SkillItem(
          name: 'Soporte L1 / L2', icon: FontAwesomeIcons.screwdriverWrench),
      SkillItem(name: 'Incidencias', icon: FontAwesomeIcons.ticket),
      SkillItem(name: 'Hardware / software', icon: FontAwesomeIcons.laptop),
      SkillItem(name: 'Moodle', icon: FontAwesomeIcons.graduationCap),
      SkillItem(name: 'Power BI', icon: FontAwesomeIcons.chartColumn),
    ],
  ),
  SkillGroup(
    title: 'Web y plataformas',
    subtitle: 'CMS, e-commerce y hosting',
    items: [
      SkillItem(name: 'WordPress', icon: FontAwesomeIcons.wordpress),
      SkillItem(name: 'WooCommerce', icon: FontAwesomeIcons.cartShopping),
      SkillItem(name: 'Odoo', icon: FontAwesomeIcons.gears),
      SkillItem(name: 'Webflow', icon: FontAwesomeIcons.paintbrush),
      SkillItem(name: 'Meta Business', icon: FontAwesomeIcons.meta),
      SkillItem(name: 'VPS', icon: FontAwesomeIcons.server),
    ],
  ),
  SkillGroup(
    title: 'IA y productividad',
    subtitle: 'Asistentes y flujo de trabajo',
    items: [
      SkillItem(name: 'Cursor', icon: FontAwesomeIcons.terminal),
      SkillItem(name: 'Claude (Anthropic)', icon: FontAwesomeIcons.robot),
      SkillItem(name: 'Modelos predictivos', icon: FontAwesomeIcons.brain),
      SkillItem(
          name: 'Asistentes de código',
          icon: FontAwesomeIcons.wandMagicSparkles),
    ],
  ),
];
