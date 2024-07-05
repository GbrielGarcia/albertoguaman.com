import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:universal_html/html.dart' as html;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

void linkWhatsApp(
  String messageC,
) async {
  String whatsappURL =
      'https://api.whatsapp.com/send/?phone=+593998602204&text=${Uri.encodeComponent(messageC)}';
  html.window.open(
    whatsappURL,
    'Link WhastApp',
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final al = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffebddff),
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              Responsive(
                mobile: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30.0),
                    CircleAvatar(
                      maxRadius: 75,
                      backgroundImage: AssetImage(
                        AssetsUtil.imgAlbertoGuaman,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Alberto Guaman',
                              style: StyleText.textStyleClassClasi(
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
                          style: StyleText.textStyleClassClasi(
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          al!.webDeveloperAndDataAnalyst,
                          style: StyleText.textStyleClassClasi(
                              fontWeight: FontWeight.w400),
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
                      backgroundImage: AssetImage(AssetsUtil.imgAlbertoGuaman),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Alberto Guaman',
                              style: StyleText.textStyleClassClasi(
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
                          style: StyleText.textStyleClassClasi(),
                        ),
                        Text(
                          al!.webDeveloperAndDataAnalyst,
                          style: StyleText.textStyleClassClasi(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget(
                    FontAwesomeIcons.linkedin,
                    () {
                      if (kDebugMode) {
                        print('linkeding');
                      }

                      html.window.open(
                        'https://www.linkedin.com/in/albertoguaman/',
                        'Linkedin',
                      );
                    },
                    color: Colors.black,
                  ),
                  iconWidget(
                    FontAwesomeIcons.instagram,
                    () {
                      html.window.open(
                        'https://www.instagram.com/albertoguamandev/',
                        'Instagram',
                      );
                    },
                    color: Colors.black,
                  ),
                  iconWidget(
                    FontAwesomeIcons.tiktok,
                    () {
                      if (kDebugMode) {
                        print('linkeding');
                      }
                      html.window.open(
                        'https://www.tiktok.com/@albertoguaman.com',
                        'Tiktok',
                      );
                    },
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              InkeContainerInfo(
                  onTap: () => linkWhatsApp(al!.informationAbout),
                  text: al!.meetMe),
              InkeContainerInfo(
                  title: al!.portfolioStyle,
                  activate: true,
                  onTap: () {
                  context.go('/portafolio');
                  },
                  text: 'Minecraft'),
              InkeContainerInfo(
                  title: al!.resource,
                  activate: true,
                  onTap: () {
                    html.window.open(
                      'https://github.com/tinguar/flutter',
                      'GitHub Tinguar',
                    );
                  },
                  text: al!.desingFlutter),
              InkeContainerInfo(
                  title: al!.services,
                  activate: true,
                  onTap: () => linkWhatsApp(al!.servicesApp),
                  text: al!.servicesAppTitle),
              InkeContainerInfo(
                  onTap: () => linkWhatsApp(al!.servicesDevWeb),
                  text: al!.servicesDevWebTitle),
              InkeContainerInfo(
                  onTap: () => linkWhatsApp(al!.servicesDisWeb),
                  text: al!.servicesDisWebTitle),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${al!.madeWithFlutter} 💕',
                    style: StyleText.textStyleClassClasi(
                        fontWeight: FontWeight.w400),
                  ),
                  const Icon(
                    Icons.flutter_dash,
                    color: Colors.lightBlue,
                  )
                ],
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
      floatingActionButton: CupertinoSwitchW(
        textStyle: StyleText.textStyleClassClasi(),
        activate: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class InkeContainerInfo extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String? title;
  final bool? activate;
  const InkeContainerInfo({
    super.key,
    required this.onTap,
    required this.text,
    this.title,
    this.activate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
          top: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: activate ?? false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  title ?? 'd',
                  style: StyleText.textStyleClassClasi(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: Responsive.isDesktop(context) ? 500 : 450,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text.toUpperCase(),
                    style: StyleText.textStyleClassClasi(
                        fontWeight: FontWeight.w400),
                  ),
                  const ColorCycleIcon(),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              width: Responsive.isDesktop(context) ? 500 : 450,
              height: 1.0,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
