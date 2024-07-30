import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:universal_html/html.dart' as html;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import '../../widgets/widgets.dart';

class Portafolio extends StatelessWidget {
  const Portafolio({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final al = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: MouseRegion(
          onEnter: (_) {
            html.document.body!.classes.add('custom-cursor');
          },
          onExit: (_) {
            html.document.body!.classes.remove('custom-cursor');
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetsUtil.imgBackgroundMinecraft,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30.0),
                Column(
                  children: <Widget>[
                    Responsive(
                        mobile: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30.0),
                            CircleAvatar(
                              maxRadius: 75,
                              backgroundImage:
                                  AssetImage(AssetsUtil.imgAlbertoGuaman),
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Alberto Guaman',
                                      style: StyleText.textStyleClass(
                                        fontSize: 35.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  al!.administratorIt,
                                  style: StyleText.textStyleClass(),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  al!.webDeveloperAndDataAnalyst,
                                  style: StyleText.textStyleClass(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        desktop: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              maxRadius: 75,
                              backgroundImage:
                                  AssetImage(AssetsUtil.imgAlbertoGuaman),
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Alberto Guaman',
                                      style: StyleText.textStyleClass(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.verified,
                                      color: Colors.blue,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                                Text(
                                  al!.administratorIt,
                                  style: StyleText.textStyleClass(),
                                ),
                                Text(
                                  al!.webDeveloperAndDataAnalyst,
                                  style: StyleText.textStyleClass(),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 40.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    containerOnpress(() {
                      html.window.open(
                        'https://tunegocio.pro/G4YbU',
                        'WhastApp',
                      );
                    }, al!.contacMe),
                    iconWidget(FontAwesomeIcons.linkedin, () {
                      if (kDebugMode) {
                        print('linkeding');
                      }

                      html.window.open(
                        'https://www.linkedin.com/in/albertoguaman/',
                        'Linkedin',
                      );
                    }),
                    iconWidget(FontAwesomeIcons.instagram, () {
                      html.window.open(
                        'https://www.instagram.com/albertoguamandev/',
                        'Instagram',
                      );
                    }),
                    iconWidget(FontAwesomeIcons.tiktok, () {
                      if (kDebugMode) {
                        print('linkeding');
                      }
                      html.window.open(
                        'https://www.tiktok.com/@albertoguaman.com',
                        'Tiktok',
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: Responsive.isDesktop(context)
                      ? EdgeInsets.symmetric(horizontal: size.width * 0.2)
                      : EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: StyleText.textStyleClass(),
                      children: [
                        TextSpan(text: al!.descriptionAbout),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 40.0),
                Text(
                  al!.proyectRealized,
                  style: StyleText.textStyleClass(
                    fontSize: Responsive.isDesktop(context) ? 75 : 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                DynamicContainersList(dataList: dataList, style: 2,),
                const SizedBox(height: 50.0)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CupertinoSwitchW(
        textStyle: StyleText.textStyleClass(),
        style: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
