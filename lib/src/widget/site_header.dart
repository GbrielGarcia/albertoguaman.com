import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/site_nav.dart';
import 'package:albertoguaman/src/widget/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Header fijo: marca + menú principal centrado.
class SiteHeader extends StatelessWidget implements PreferredSizeWidget {
  const SiteHeader({
    super.key,
    this.actions = const [],
    this.showDrawerButton = true,
    this.showChromeToggles = true,
  });

  final List<Widget> actions;
  final bool showDrawerButton;
  final bool showChromeToggles;

  static const double _barHeight = 56;
  static const double _navHeight = 44;

  @override
  Size get preferredSize => const Size.fromHeight(_barHeight + _navHeight);

  @override
  Widget build(BuildContext context) {
    final isNarrow = context.isMobile || context.isMobileLarge;

    return AppBar(
      backgroundColor: UtilsColor.colorBg.withValues(alpha: 0.96),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: _barHeight,
      centerTitle: !isNarrow,
      iconTheme: IconThemeData(color: UtilsColor.colorSecondaryWhite),
      automaticallyImplyLeading: showDrawerButton,
      title: GestureDetector(
        onTap: () => context.go('/'),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            'Alberto Guaman',
            style: StyleText.textPortfolio(
              fontSize: isNarrow ? 16 : 18,
              fontWeight: FontWeight.w800,
              color: UtilsColor.colorSecondaryWhite,
            ),
          ),
        ),
      ),
      actions: [
        ...actions,
        if (showChromeToggles) const ThemeToggleButton(),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(_navHeight),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: UtilsColor.hairline),
            ),
          ),
          padding: EdgeInsets.only(
            left: SizeUtils.m,
            right: SizeUtils.m,
            bottom: SizeUtils.s / 2,
          ),
          child: const SiteNav(compact: true),
        ),
      ),
    );
  }
}
