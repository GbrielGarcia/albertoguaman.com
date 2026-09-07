class ButtonModel {
  final String name;
  final String url;

  const ButtonModel({required this.name, required this.url});
}

const List<ButtonModel> infoButtonModel = [
  ButtonModel(name: 'whatsapp', url: 'https://wa.me/593992889078'),
  ButtonModel(
      name: 'linkedin', url: 'https://www.linkedin.com/in/albertoguaman'),
  ButtonModel(name: 'github', url: 'https://github.com/GbrielGarcia'),
];
