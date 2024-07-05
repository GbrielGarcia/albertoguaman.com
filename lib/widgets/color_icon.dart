import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColorCycleIcon extends StatefulWidget {
  const ColorCycleIcon({super.key});

  @override
  _ColorCycleIconState createState() => _ColorCycleIconState();
}

class _ColorCycleIconState extends State<ColorCycleIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return FaIcon(FontAwesomeIcons.arrowRightFromBracket,
            color: _colorAnimation.value);
      },
    );
  }
}