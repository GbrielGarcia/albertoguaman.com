import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double minSize;
  final double maxSize;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ResponsiveText({
    Key? key,
    required this.text,
    required this.minSize,
    required this.maxSize,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculamos el tamaño del texto
    double calculatedFontSize =
        screenWidth * 0.05; // Ajusta 0.05 según tus necesidades
    double fontSize = calculatedFontSize.clamp(minSize, maxSize);

    return Text(
      text,
      style:
      style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize),
      textAlign: textAlign,
    );
  }
}