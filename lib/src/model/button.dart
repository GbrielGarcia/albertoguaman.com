import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonModel {
  final String name;
  final String url;
  final IconData icon;

  ButtonModel({required this.name, required this.url, required this.icon});
}


List<ButtonModel> infoButtonModel = [
  ButtonModel(name: 'whatsapp', url: 'https://tunegocio.pro/AWcDD', icon: FontAwesomeIcons.whatsapp),
  ButtonModel(name: 'tiktok', url: 'https://www.tiktok.com/@albertoguaman.com', icon: FontAwesomeIcons.tiktok),
  ButtonModel(name: 'instagram', url: 'https://www.instagram.com/albertoguamandev/', icon: FontAwesomeIcons.instagram),
  ButtonModel(name: 'facebook', url: 'https://www.facebook.com/albertoguamantinguar', icon: FontAwesomeIcons.facebook),
  ButtonModel(name: 'github', url: 'https://github.com/tinguar', icon: FontAwesomeIcons.github),
];