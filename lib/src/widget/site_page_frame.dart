import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Marco de página con header fijo (menú arriba).
class SitePageFrame extends StatelessWidget {
  const SitePageFrame({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions = const [],
    this.maxWidth = 1040,
    this.showWhatsAppFab = true,
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final List<Widget> actions;
  final double maxWidth;
  final bool showWhatsAppFab;

  @override
  Widget build(BuildContext context) {
    final isNarrow = context.isMobile || context.isMobileLarge;
    final titleSize = TextStyleSize.textTitleSectionSize(context.screenWidth);

    return Scaffold(
      backgroundColor: UtilsColor.colorBg,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: showWhatsAppFab
          ? FloatingActionButton.extended(
              onPressed: () => laucherURL('https://wa.me/593992889078'),
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              elevation: 6,
              icon: const Icon(Icons.chat),
              label: const Text(
                'WhatsApp',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          : null,
      drawer: Drawer(
        backgroundColor: UtilsColor.colorBg,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.l,
              vertical: SizeUtils.xl,
            ),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.go('/');
                },
                child: Text(
                  'Alberto Guaman',
                  style: StyleText.textPortfolio(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: UtilsColor.colorSecondaryWhite,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(height: SizeUtils.xl),
              SiteNav(
                axis: Axis.vertical,
                onNavigate: () => Navigator.pop(context),
              ),
              if (actions.isNotEmpty) ...[
                SizedBox(height: SizeUtils.l),
                ...actions,
              ],
            ],
          ),
        ),
      ),
      appBar: SiteHeader(actions: actions),
      body: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(color: UtilsColor.colorBg),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 220,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      UtilsColor.colorBg.withValues(alpha: 0),
                      UtilsColor.colorBlue.withValues(alpha: 0.06),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: BubbleBackgroundLayer(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  isNarrow ? SizeUtils.l : SizeUtils.xl,
                  SizeUtils.l,
                  isNarrow ? SizeUtils.l : SizeUtils.xl,
                  SizeUtils.m,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          style: StyleText.textPortfolio(
                            fontSize: titleSize * 1.05,
                            fontWeight: FontWeight.w800,
                            color: UtilsColor.colorSecondaryWhite,
                            height: 1.05,
                          ),
                        ),
                        if (subtitle != null &&
                            subtitle!.trim().isNotEmpty) ...[
                          SizedBox(height: SizeUtils.m),
                          Text(
                            subtitle!,
                            style: StyleText.textPortfolio(
                              fontSize: TextStyleSize.textDescriptionSize(
                                  context.screenWidth),
                              color: UtilsColor.colorMuted,
                              height: 1.45,
                            ),
                          ),
                        ],
                        SizedBox(height: SizeUtils.xl),
                        body,
                        SizedBox(height: SizeUtils.xxl),
                        footerData(
                          AppLocalizations.of(context),
                          context.screenWidth,
                        ),
                        SizedBox(height: SizeUtils.xl1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const BubbleBackgroundToggleOverlay(),
        ],
      ),
    );
  }
}
