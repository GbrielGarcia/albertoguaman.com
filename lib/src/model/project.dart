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
      type: ['POS', 'Web', 'Android', 'Tinguar'],
      title: 'Mi Negocio Listo',
      description:
          'POS, facturación electrónica SRI, inventario, caja y catálogo digital para una o varias tiendas. Vende en mostrador y en línea, imprime tickets térmicos y envía comprobantes por WhatsApp. Web: minegociolisto.com · App Android en Google Play.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://minegociolisto.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Streaming', 'Web', 'Tinguar'],
      title: 'Streaming Distribuidores',
      description:
          'Panel de distribuidores para comprar, renovar y administrar cuentas de streaming con saldo, entrega inmediata y renovación sin perder datos.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://distribuidores.streamingecu.com/login'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Flutter', 'Dart', 'Web'],
      title: 'Tarot Pragmático',
      description:
          'Perfil de Arcano Personal y mapas de tarot en Flutter (Android y Web): cálculo por fecha de nacimiento, mapas anuales y comparación de vínculo.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://perfil.tarotpragmatico.com/'),
];
