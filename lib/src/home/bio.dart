import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';
import '../widget/widget.dart';
import 'home.dart';

class Bio extends StatelessWidget {
  const Bio({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final titleSize = TextStyleSize.textTitleSectionSize(context.screenWidth);
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final isNarrow = context.isMobile || context.isMobileLarge;

    return Scaffold(
      backgroundColor: UtilsColor.colorPrimaryDark,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => laucherURL('https://wa.me/593992889078'),
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        elevation: 10,
        icon: const Icon(Icons.chat),
        label: const Text(
          'WhatsApp',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: UtilsColor.colorSecondaryWhite,
          onPressed: () => context.go('/'),
          tooltip: al?.backToHome ?? 'Volver al inicio',
        ),
        title: Text(
          al?.aboutMe ?? 'Sobre mí',
          style: StyleText.textPortfolio(
            fontSize: TextStyleSize.textTitleSize(context.screenWidth),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: BubbleBackgroundLayer(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.s,
                  vertical: SizeUtils.s,
                ),
                child: ResponsiveCenter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SiteNav(),
                      SizedBox(height: SizeUtils.l),
                      buildRowName(context, animateEntrance: true),
                      SizedBox(height: SizeUtils.l),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(SizeUtils.l),
                        decoration: BoxDecoration(
                          color:
                              UtilsColor.colorSurface.withValues(alpha: 0.85),
                          border: Border.all(
                            color: UtilsColor.colorSecondaryWhite
                                .withValues(alpha: 0.08),
                          ),
                          borderRadius: BorderRadius.circular(SizeUtils.l),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: titleSize * 0.7,
                                  decoration: BoxDecoration(
                                    color: UtilsColor.colorBlue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                SizedBox(width: SizeUtils.s),
                                Text(
                                  (al?.aboutMe ?? 'Sobre mí').toUpperCase(),
                                  style: StyleText.textPortfolio(
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.w700,
                                    color: UtilsColor.colorSecondaryWhite,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: SizeUtils.m),
                            const AboutProfileContent(
                              textAlign: TextAlign.start,
                              descriptionBold: false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeUtils.l),
                      Text(
                        'Contacto y CV'.toUpperCase(),
                        style: StyleText.textPortfolio(
                          fontSize: bodySize,
                          fontWeight: FontWeight.bold,
                          color: UtilsColor.colorBlue,
                        ),
                      ),
                      SizedBox(height: SizeUtils.m),
                      if (isNarrow) ...[
                        containerBottom(
                          () => context.go('/'),
                          'https://www.albertoguaman.com/',
                          al?.portfolio ?? 'Portafolio',
                          width: double.infinity,
                        ),
                        containerBottom(
                          () => laucherURL(AssetsUtil.cvDev2026),
                          AssetsUtil.cvDev2026,
                          'cv_sep_2026',
                          width: double.infinity,
                        ),
                        containerBottom(
                          () => laucherURL('https://wa.me/593992889078'),
                          '+593 99 288 9078',
                          al?.contacMe ?? 'Contáctame',
                          width: double.infinity,
                          variant: PortfolioButtonVariant.solid,
                        ),
                      ] else
                        Row(
                          children: [
                            Expanded(
                              child: containerBottom(
                                () => context.go('/'),
                                'https://www.albertoguaman.com/',
                                al?.portfolio ?? 'Portafolio',
                                width: double.infinity,
                              ),
                            ),
                            Expanded(
                              child: containerBottom(
                                () => laucherURL(AssetsUtil.cvDev2026),
                                AssetsUtil.cvDev2026,
                                'cv_sep_2026',
                                width: double.infinity,
                              ),
                            ),
                            Expanded(
                              child: containerBottom(
                                () => laucherURL('https://wa.me/593992889078'),
                                '+593 99 288 9078',
                                al?.contacMe ?? 'Contáctame',
                                width: double.infinity,
                                variant: PortfolioButtonVariant.solid,
                              ),
                            ),
                          ],
                        ),
                      if (al != null) ...[
                        SizedBox(height: SizeUtils.xl),
                        footerData(al, context.screenWidth),
                        SizedBox(height: SizeUtils.xl1),
                      ],
                    ],
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
