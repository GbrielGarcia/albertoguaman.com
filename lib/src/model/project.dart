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
      type: ['PhP', 'Laravel', 'MySql'],
      title: 'Gestión integral de Cuentas',
      description:
          'Gestión integral de ventas 24/7 para servicios de Streaming, con recarga de saldo.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tinguar.com/streaming-saas/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Flutter', 'Firebase', 'Dart'],
      title: 'Creacion de enlaces cortos',
      description:
          'Creacion y Generador de enlaces cortos para WhatsApp con mensaje personalizado.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tunegocio.tinguar.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['WordPress', 'Elementor', 'Hostinger'],
      title: 'AxxonImagen',
      description:
          'Especialistas en diagnósticos por ecografícas para la ciudad de Santo Domingo.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://axxonimagen.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Flutter', 'Dart', 'Firebase'],
      title: 'Horarios Energia',
      description:
          'Aquí puedes consultar los horarios de corte de energía programados por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: [
        'Php',
        'Meta (FACEBOOK)',
      ],
      title: 'Chat Bot Energia',
      description:
          'Consulta los cortes de energía de manera rápida y sencilla a través de nuestro chatbot en WhatsApp.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tunegocio.pro/PMGwa'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Flutter', 'Dart', 'Firebase'],
      title: 'Tarot Pragmático',
      description:
          'Sistema Arcano desarrollado en Flutter tanto para (Android & Web) para un cliente en Chile.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://perfil.tarotpragmatico.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Wordpress', 'Elementor', 'Css'],
      title: 'Sciedtec',
      description:
          'Página web desarrollada con WordPress y Elementor para una empresa ecuatoriana dedicada a la educación.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://sciedtec.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Wordpress', 'Elementor', 'Css'],
      title: 'Lars Tree Services',
      description:
          'Página web realizada con CMS para una empresa de EEUU. especialista en servicios de limpieza de árboles.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://larstreeservice.com/'),
  ProjectModel(
      photo: AssetsUtil.projectOne,
      type: ['Wordpress', 'Elementor', 'Css'],
      title: 'Arminox',
      description:
          'Página creada con un CMS para ofrecer servicios de metalurgia en Ecuador.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://arminoxec.com/'),
];
