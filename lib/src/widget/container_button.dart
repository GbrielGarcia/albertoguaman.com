import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'widget.dart';

enum PortfolioButtonVariant { solid, outline, soft }

Widget containerBottom(
  VoidCallback onTap,
  String message,
  String text, {
  Color? color,
  Color? colorBorder,
  double? padding,
  double? width,
  PortfolioButtonVariant variant = PortfolioButtonVariant.outline,
}) {
  final isSolid = variant == PortfolioButtonVariant.solid || color != null;
  final isSoft = variant == PortfolioButtonVariant.soft;

  final bg = color ??
      (isSolid
          ? UtilsColor.colorBlue
          : isSoft
              ? UtilsColor.colorSecondaryWhite.withValues(alpha: 0.06)
              : Colors.transparent);
  final border = colorBorder ??
      (isSolid ? bg : UtilsColor.hairline);
  final fg = isSolid
      ? (UtilsColor.useLight
          ? Colors.white
          : UtilsColor.colorSecondaryWhite)
      : UtilsColor.colorSecondaryWhite.withValues(alpha: 0.92);

  return Padding(
    padding: EdgeInsets.all(padding ?? SizeUtils.s),
    child: tooltipW(
      message,
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          hoverColor: UtilsColor.colorBlue.withValues(alpha: 0.12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: width,
            decoration: BoxDecoration(
              color: bg,
              border: Border.all(color: border, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.m,
                vertical: SizeUtils.s1 * 0.85,
              ),
              child: Text(
                text.toUpperCase(),
                style: StyleText.textPortfolio(
                  fontSize: SizeUtils.s1,
                  fontWeight: FontWeight.w600,
                  color: fg,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
