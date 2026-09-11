import '../utils/utils.dart';

class ProjectModel {
  final String photo;
  final List<String> type;
  final String title;
  final String description;
  final String buttonText;
  final String buttonVoidCall;

  ProjectModel({
    required this.photo,
    required this.type,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonVoidCall,
  });
}

/// Solo proyectos/productos con enlace público visible (como en Tinguar:
/// publicProfile + hasWebsite).
List<ProjectModel> infoProjectModel = [
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Desktop', 'WhatsApp', 'Tinguar'],
      title: 'Rapidito',
      description:
          'Campañas de WhatsApp desde tu PC (Windows y macOS), con ritmo controlado. Sube tu lista CSV, personaliza mensajes con variables, adjunta archivos y envía con licencia por equipo e auto-update.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tinguar.com/productos/rapidito/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['POS', 'Web', 'Android', 'Tinguar'],
      title: 'Mi Negocio Listo',
      description:
          'POS, facturación electrónica SRI, inventario, caja y catálogo digital para una o varias tiendas. Vende en mostrador y en línea, imprime tickets térmicos y envía comprobantes por WhatsApp. Web: minegociolisto.com · App Android en Google Play.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://minegociolisto.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Streaming', 'Web'],
      title: 'Streaming Ecuador - Distribuidores',
      description:
          'Panel de distribuidores para comprar, renovar y administrar cuentas de streaming con saldo, entrega inmediata y renovación sin perder datos.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://distribuidores.streamingecu.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Streaming', 'Web'],
      title: 'Streaming Ecuador',
      description:
          'Sitio web informativo SEO Friendly para Streaming Ecuador, desarrollado con Astro y Tailwind CSS.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://streamingecu.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Flutter', 'Dart', 'Web'],
      title: 'Tarot Pragmático - Calculadora de Arcanos',
      description:
          'Perfil de Arcano Personal y mapas de tarot en Flutter (Android y Web): cálculo por fecha de nacimiento, mapas anuales y comparación de vínculo.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://perfil.tarotpragmatico.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Web', 'Astro'],
      title: 'Tarot Pragmático',
      description:
          'Plataforma web de tarot pragmático con lecturas personalizadas y consultas espirituales.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tarotpragmatico.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['WordPress', 'Web'],
      title: 'EMAPASOSQ-EP',
      description:
          'Sitio institucional de la Empresa Municipal de Agua Potable y Alcantarillado (Quinindé): transparencia, denuncia ciudadana, bolsa de empleo y blog.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://emapasosq-ep.gob.ec/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Astro', 'Web'],
      title: 'Tatiana Jiménez Abogada',
      description:
          'Sitio profesional para abogada en Derecho Penal, Tránsito, Civil y Familia, con servicios, consultas en línea y contacto.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tatianaabogada.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['WordPress', 'Web'],
      title: 'Inox Hierro',
      description:
          'Sitio web para fabricación de pasamanos en acero inoxidable y accesorios para barandillas y vidrio templado.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://inoxhierroec.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['WordPress', 'Web'],
      title: 'Lars Tree Services',
      description:
          'Sitio web de servicios de cuidado de árboles: poda, remoción, trasplante y mantenimiento.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://www.larstreeservice.info'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['WordPress', 'Web'],
      title: 'Daniel Jaramillo Abogado',
      description:
          'Sitio profesional de servicios jurídicos: asesoría, patrocinio y defensa legal.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://daniel-jaramillo-abogados.com/'),
];
