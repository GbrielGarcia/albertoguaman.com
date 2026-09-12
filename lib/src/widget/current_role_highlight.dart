import 'package:flutter/material.dart';

import '../utils/utils.dart';

/// Resalta el puesto laboral actual con borde pulsante y sello "Actual".
class CurrentRoleHighlight extends StatefulWidget {
  const CurrentRoleHighlight({
    super.key,
    required this.child,
    this.showBadge = true,
  });

  final Widget child;
  final bool showBadge;

  @override
  State<CurrentRoleHighlight> createState() => _CurrentRoleHighlightState();
}

class _CurrentRoleHighlightState extends State<CurrentRoleHighlight>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final t = _pulse.value;
        final glow = Color.lerp(
          UtilsColor.colorYellowBright,
          UtilsColor.colorPink,
          t,
        )!;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeUtils.m + 2),
                border: Border.all(
                  color: glow.withValues(alpha: 0.55 + (t * 0.35)),
                  width: 1.5 + (t * 0.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: glow.withValues(alpha: 0.18 + (t * 0.22)),
                    blurRadius: 10 + (t * 14),
                    spreadRadius: 0.5 + (t * 1.5),
                  ),
                ],
              ),
              child: child,
            ),
            if (widget.showBadge)
              Positioned(
                top: -10,
                left: SizeUtils.s,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: glow,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: glow.withValues(alpha: 0.45),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.s,
                      vertical: SizeUtils.m,
                    ),
                    child: Text(
                      'ACTUAL',
                      style: StyleText.textPortfolio(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: UtilsColor.colorPrimaryDark,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
