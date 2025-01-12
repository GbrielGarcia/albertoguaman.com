import "package:albertoguaman/router/routers.dart";
import "package:albertoguaman/src/home/home.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeUtils.xl1),
              buildAvatar(context, al),
              SizedBox(width: SizeUtils.m),
              buildRowName(context, visibility: true),
              SizedBox(
                width: getWidthText(context),
                child: Center(
                  child: Text(
                    al!.descriptionAbout,
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
              }, 'https://www.albertoguaman.com/inicio', 'Portafolio', width: double.infinity),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeUtils.s1),
        child: footerData(al, context.screenWidth),
      ),
    );
  }
}
