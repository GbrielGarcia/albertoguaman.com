import "package:albertoguaman/src/home/home.dart";
import 'package:albertoguaman/l10n/app_localizations.dart';

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "../model/model.dart";
import "../utils/utils.dart";

import "../widget/widget.dart";

class Bio extends StatelessWidget {
  const Bio({super.key});

  @override
  Widget build(BuildContext context) {
    double getWidthText(BuildContext context) {
      if (context.isMobile || context.isMobileLarge || context.isTablet) {
        return context.screenWidth * 0.9;
      }
      return context.screenWidth * 0.8;
    }

    final al = AppLocalizations.of(context);

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
          tooltip: 'Volver al inicio',
        ),
        title: Text(
          'Sobre mí',
          style: StyleText.textPortfolio(
            fontSize: TextStyleSize.textTitleSize(context.screenWidth),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeUtils.xl1),
              buildRowName(context, visibility: true),
              SizedBox(
                width: getWidthText(context),
                child: Center(
                  child: Text(
                    al?.descriptionAbout ?? '',
                    style: StyleText.textPortfolio(
                      fontWeight: FontWeight.bold,
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: SizeUtils.xl),
              containerBottom(() {
                context.go('/');
              }, 'https://www.albertoguaman.com/inicio', 'Portafolio',
                  width: double.infinity),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: infoButtonModel.length,
                  itemBuilder: (context, index) {
                    final button = infoButtonModel[index];
                    return containerBottom(
                      () => laucherURL(button.url),
                      button.url,
                      button.name,
                    );
                  }),
              if (al != null) ...[
                SizedBox(height: SizeUtils.xl),
                footerData(al, context.screenWidth),
                SizedBox(height: SizeUtils.xl1),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
