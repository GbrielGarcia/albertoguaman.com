import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/site_nav.dart';
import 'package:flutter/material.dart';

/// Shell común alineado a la paleta del portafolio.
class PortfolioScaffold extends StatelessWidget {
  const PortfolioScaffold({
    super.key,
    required this.body,
    this.title,
    this.showNavInBody = true,
    this.maxWidth = 1100,
  });

  final Widget body;
  final String? title;
  final bool showNavInBody;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final isNarrow = context.isMobile || context.isMobileLarge;

    return Scaffold(
      backgroundColor: UtilsColor.colorBg,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => laucherURL('https://wa.me/593992889078'),
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        elevation: 8,
        icon: const Icon(Icons.chat),
        label: const Text(
          'WhatsApp',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      drawer: isNarrow
          ? Drawer(
              backgroundColor: UtilsColor.colorBg,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(SizeUtils.m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ALBERTO GUAMAN',
                        style: StyleText.textPortfolio(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: UtilsColor.colorSecondaryWhite,
                        ),
                      ),
                      SizedBox(height: SizeUtils.l),
                      SiteNav(
                        axis: Axis.vertical,
                        onNavigate: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: UtilsColor.colorBg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: UtilsColor.colorSecondaryWhite),
        title: title == null
            ? null
            : Text(
                title!,
                style: StyleText.textPortfolio(
                  fontSize: TextStyleSize.textTitleSize(context.screenWidth),
                  fontWeight: FontWeight.w800,
                  color: UtilsColor.colorSecondaryWhite,
                ),
              ),
        actions: isNarrow
            ? null
            : [
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Center(child: SiteNav()),
                ),
              ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isNarrow ? SizeUtils.m : SizeUtils.xl,
          vertical: SizeUtils.m,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isNarrow && showNavInBody) ...[
                  const SiteNav(),
                  SizedBox(height: SizeUtils.l),
                ],
                body,
                SizedBox(height: SizeUtils.xl1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
