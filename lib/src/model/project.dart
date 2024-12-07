import 'package:albertoguaman/src/util/assets.dart';

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
      photo: Assets.projectOne,
      type: [],
      title: 'Horarios Energia',
      description:
          'Aquí puedes acceder a los horarios de corte de energia programado por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),
  ProjectModel(
      photo: Assets.projectOne,
      type: [],
      title: 'Horarios Energia',
      description:
          'Consulta los cortes de energía a través de nuestro chatbot en WhatsApp.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://tunegocio.pro/PMGwa'),
  ProjectModel(
      photo: Assets.projectOne,
      type: [],
      title: 'Tarot Pragmático',
      description:
          'Sistema Arcano para cliente de CHILE, desarrollado con Flutter.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://perfil.tarotpragmatico.com/'),
  ProjectModel(
      photo: Assets.projectOne,
      type: [],
      title: 'Página Web Educativa',
      description:
          'Página realizada con WordPress y Elementor para una empresa ecuatoriana de educación.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://sciedtec.com/'),

];
