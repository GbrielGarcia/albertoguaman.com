import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

class DarkInfoCard extends StatelessWidget {
  const DarkInfoCard({
    super.key,
    required this.child,
    this.title,
    this.padding,
  });

  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(SizeUtils.l),
      decoration: BoxDecoration(
        color: UtilsColor.colorCardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: StyleText.textPortfolio(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: UtilsColor.colorSecondaryWhite,
              ),
            ),
            SizedBox(height: SizeUtils.m),
          ],
          child,
        ],
      ),
    );
  }
}

class MetricCircle extends StatelessWidget {
  const MetricCircle({
    super.key,
    required this.value,
    required this.label,
    this.size = 140,
  });

  final String value;
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: UtilsColor.colorBlue.withValues(alpha: 0.12),
        border: Border.all(color: UtilsColor.colorBlue, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: StyleText.textPortfolio(
              fontSize: size * 0.18,
              fontWeight: FontWeight.w800,
              color: UtilsColor.colorBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: StyleText.textPortfolio(
              fontSize: size * 0.09,
              fontWeight: FontWeight.w600,
              color: UtilsColor.colorCharcoal,
            ),
          ),
        ],
      ),
    );
  }
}

class FolderSection extends StatelessWidget {
  const FolderSection({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.child,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                GestureDetector(
                  onTap: () => onTabSelected(i),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.only(right: SizeUtils.s),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.m,
                        vertical: SizeUtils.s,
                      ),
                      decoration: BoxDecoration(
                        color: i == selectedIndex
                            ? UtilsColor.colorBlue
                            : UtilsColor.colorBlue.withValues(alpha: 0.2),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        tabs[i].toUpperCase(),
                        style: StyleText.textPortfolio(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: i == selectedIndex
                              ? UtilsColor.colorSecondaryWhite
                              : UtilsColor.colorCharcoal,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(SizeUtils.l),
          decoration: BoxDecoration(
            color: UtilsColor.colorBlue,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}

class ProcessStep extends StatelessWidget {
  const ProcessStep({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: UtilsColor.colorBlue,
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        SizedBox(height: SizeUtils.s),
        Text(
          label,
          textAlign: TextAlign.center,
          style: StyleText.textPortfolio(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
