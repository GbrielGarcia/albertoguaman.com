import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/home/home.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cv_print_stub.dart' if (dart.library.html) 'cv_print_web.dart'
    as print_impl;

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final isNarrow = context.isMobile || context.isMobileLarge;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return Scaffold(
      backgroundColor: UtilsColor.colorPrimaryDark,
      drawer: isNarrow
          ? Drawer(
              backgroundColor: UtilsColor.colorPrimaryDark,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: SizeUtils.xl1),
                    buildRowName(
                      context,
                      visibility: true,
                      visibilityNameW: true,
                      text: 'Alberto Guaman'.toUpperCase(),
                    ),
                    SizedBox(height: SizeUtils.s1),
                    SiteNav(
                      axis: Axis.vertical,
                      onNavigate: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: UtilsColor.colorPrimaryDark,
        elevation: 0,
        iconTheme: IconThemeData(color: UtilsColor.colorSecondaryWhite),
        title: Text(
          al.cvPageTitle,
          style: StyleText.textPortfolio(
            fontSize: TextStyleSize.textTitleSize(context.screenWidth),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: BubbleBackgroundLayer(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isNarrow ? SizeUtils.m : SizeUtils.xl,
                  vertical: SizeUtils.m,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 960),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SiteNav(),
                        SizedBox(height: SizeUtils.l),
                        Text(
                          al.cvPageHint,
                          style: StyleText.textPortfolio(
                            fontSize: bodySize,
                            color: UtilsColor.colorMuted,
                          ),
                        ),
                        SizedBox(height: SizeUtils.m),
                        Row(
                          children: [
                            Expanded(
                              child: containerBottom(
                                () => laucherURL(AssetsUtil.cvDev2026),
                                AssetsUtil.cvDev2026,
                                al.downloadCv,
                                width: double.infinity,
                                variant: PortfolioButtonVariant.solid,
                              ),
                            ),
                            if (kIsWeb)
                              Expanded(
                                child: containerBottom(
                                  () => print_impl.printCvPage(),
                                  al.printCv,
                                  al.printCv,
                                  width: double.infinity,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: SizeUtils.l),
                        buildCvPreview(
                          pdfUrl: AssetsUtil.cvDev2026,
                          height: isNarrow ? 560 : 900,
                        ),
                        SizedBox(height: SizeUtils.xl),
                        footerData(al, context.screenWidth),
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
