import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonModel {
  final String name;
  final String url;
  final FaIconData icon;

  ButtonModel({required this.name, required this.url, required this.icon});
}

List<ButtonModel> infoButtonModel = [
  ButtonModel(
      name: 'whatsapp',
      url: 'https://wa.me/593992889078',
      icon: FontAwesomeIcons.whatsapp),
  ButtonModel(
      name: 'linkedin',
      url: 'https://www.linkedin.com/in/albertoguaman',
      icon: FontAwesomeIcons.linkedinIn),
  ButtonModel(
      name: 'instagram',
      url: 'https://www.instagram.com/albertoguamandev/',
      icon: FontAwesomeIcons.instagram),
  ButtonModel(
      name: 'tiktok',
      url: 'https://www.tiktok.com/@albertoguaman.com',
      icon: FontAwesomeIcons.tiktok),
  ButtonModel(
      name: 'github',
      url: 'https://github.com/GbrielGarcia',
      icon: FontAwesomeIcons.github),
];
