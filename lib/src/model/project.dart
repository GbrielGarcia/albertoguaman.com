import 'package:albertoguaman/src/util/assets.dart';

class ProjectModel {
  final String photo;
  final String type;
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
      type: 'Desarrollo Web',
      title: 'Horarios Energia ( CNEL )',
      description: 'Aquí puedes acceder a los horarios de corte de energia programado por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),
  ProjectModel(
      photo: Assets.projectOne,
      type: 'Desarrollo Web',
      title: 'Horarios Energia ( CNEL )',
      description: 'Aquí puedes acceder a los horarios de corte de energia programado por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),
  ProjectModel(
      photo: Assets.projectOne,
      type: 'Desarrollo Web',
      title: 'Horarios Energia ( CNEL )',
      description: 'Aquí puedes acceder a los horarios de corte de energia programado por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),  ProjectModel(
      photo: Assets.projectOne,
      type: 'Desarrollo Web',
      title: 'Horarios Energia ( CNEL )',
      description: 'Aquí puedes acceder a los horarios de corte de energia programado por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),
  ProjectModel(
      photo: Assets.projectOne,
      type: 'Desarrollo Web',
      title: 'Horarios Energia ( CNEL )',
      description: 'Aquí puedes acceder a los horarios de corte de energia programado por CNEL en tu zona.',
      buttonText: 'ver proyecto',
      buttonVoidCall: 'https://cnel-ficha.tinguar.com/'),
];
