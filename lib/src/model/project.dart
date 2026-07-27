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
      type: ['POS', 'Web', 'Tinguar'],
      title: 'Mi Negocio Listo',
      description:
          'POS, inventario, caja y catálogo digital para una o varias tiendas. Vende en mostrador y en línea, imprime tickets térmicos y envía comprobantes por WhatsApp. Disponible en web; Android próximamente.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tinguar.com/productos/mi-negocio-listo/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Streaming', 'PWA', 'Tinguar'],
      title: 'Streaming Distribuidores',
      description:
          'Panel admin y panel cliente para vender por tiempo, controlar vencimientos y renovaciones, con tienda, compras y soporte por tickets en un solo sistema.',
      buttonText: 'ver proyecto',
      buttonVoidCall:
          'https://tinguar.com/productos/streaming-distribuidores/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Web', 'Tinguar'],
      title: 'Inox Hierro',
      description:
          'Sitio web para empresa ecuatoriana especializada en acero inoxidable: servicios, galería, cotizaciones y presencia digital. Desarrollado por Tinguar.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://inoxhierroec.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Flutter', 'Dart', 'Firebase'],
      title: 'Tarot Pragmático',
      description:
          'Sistema Arcano desarrollado en Flutter tanto para (Android & Web) para un cliente en Chile.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://perfil.tarotpragmatico.com/'),
];
