import 'package:albertoguaman/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/utils.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dataList = [
      {
        'title': 'Tinguar ',
        'country': 'Ecuador ',
        'proyect': 'Generador de link',
        'skill': 'Flutter, Dart, Firebase',
        'jobs': 'Freelancer',
        'link': 'https://tiendas.tinguar.com/',
      },
      {
        'title': 'Sciedtec ',
        'country': 'Ecuador ',
        'proyect': 'Pagina web',
        'skill': 'Js, Css, Wordpress',
        'jobs': 'Contrato',
        'link': 'https://sciedtec.com/',
      },
      {
        'title': 'N/A ',
        'country': 'Ecuador ',
        'proyect': 'Alimentacion Saludable',
        'skill': 'Flutter, Dart, SqLite',
        'jobs': 'Freelancer',
        'link': 'https://itsjapon.edu.ec/apps/',
      },
      {
        'title': 'N/A ',
        'country': 'Ecuador ',
        'proyect': 'Portafolio',
        'skill': 'Flutter, Dart',
        'jobs': 'Propio',
        'link': 'https://albertoguaman.com',
      },
      {
        'title': 'All Clean Ways ',
        'country': 'Estados Unidos ',
        'proyect': 'Diseño Web - CMS',
        'skill': 'Js, Css, Wordpress',
        'jobs': 'Freelancer',
        'link': 'https://allcleanways.com/',
      },
      {
        'title': 'Inox Hierro ',
        'country': 'Ecuador ',
        'proyect': 'Diseño Web - CMS',
        'skill': 'Js, Css, Wordpress',
        'jobs': 'Freelancer',
        'link': 'https://inoxhierroec.com/',
      },
      {
        'title': 'Arminox ',
        'country': 'Ecuador ',
        'proyect': 'Diseño Web - CMS',
        'skill': 'Js, Css, Wordpress',
        'jobs': 'Freelancer',
        'link': 'https://arminoxec.com/',
      },
      {
        'title': 'Lars Tree Service ',
        'country': 'Estados Unidos ',
        'proyect': 'Diseño Web - CMS',
        'skill': 'Js, Css, Wordpress',
        'jobs': 'Freelancer',
        'link': 'https://larstreeservice.com/',
      }
    ];

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
                    },
                        al!.contacMe

                    ),
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
                Responsive(
                  mobile: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                  tablet: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                  desktop: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
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
                ),
                const SizedBox(height: 40.0),
                Text(
                  al!.proyectRealized,
                  style: StyleText.textStyleClass(
                    fontSize: Responsive.isDesktop(context) ? 75 : 50,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                DynamicContainersList(dataList: dataList),
                const SizedBox(height: 50.0)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SafeArea(
        child: PopupMenuButtonWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class PopupMenuButtonWidget extends StatefulWidget {
  const PopupMenuButtonWidget({super.key});

  @override
  State<PopupMenuButtonWidget> createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  String _selecLanguegeCode = 'en';
  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);

    return PopupMenuButton<String>(
      initialValue: '',
      icon: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AssetsUtil.imgBackgroundMinecraft,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Idioma'.toUpperCase(),
            style: StyleText.textStyleClass(),
          ),
        ),
      ),
      tooltip: al!.selectLanguage,
      onSelected: (String value) {
        setState(() {
          _selecLanguegeCode = value;
        });
        _onLanguageSelected(context);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(child: Text('English'), value: 'en'),
        PopupMenuItem(child: Text('Español'), value: 'es'),
        PopupMenuItem(child: Text('Postugúes'), value: 'pt')
      ],
    );
  }

  void _onLanguageSelected(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    Locale newLocale = _getLocale(_selecLanguegeCode);
    localeProvider.changeLocale(newLocale);
  }

  Locale _getLocale(String languajeCode) {
    switch (languajeCode) {
      case 'en':
        return const Locale('en');
      case 'es':
        return const Locale('es');
      case 'pt':
        return const Locale('pt');
      default:
        return const Locale('en');
    }
  }
}

class DynamicContainersList extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const DynamicContainersList({
    Key? key,
    required this.dataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final al = AppLocalizations.of(context);

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width >= 1024
                ? 3 // Desktop
                : size.width >= 700
                    ? 2 // Tablet y Mobile Large
                    : 1, // Mobile // Número de columnas en el grid
            crossAxisSpacing: 10.0, // Espacio entre columnas
            mainAxisSpacing: 10.0, // Espacio entre filas
            childAspectRatio: size.width >= 1024
                ? 1.6 // Desktop
                : size.width >= 700
                    ? 1.3 // Tablet y Mobile Large
                    : 1.3, // relacion de altura y ancho
          ),
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            final data = dataList[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: Responsive.isDesktop(context)
                      ? size.width * 0.3
                      : size.width * 0.9,
                  height: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AssetsUtil.imgContainerMinecraft,
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      rowInfoContainer(
                        al!.company,
                        data['title'],
                      ),
                      rowInfoContainer(
                        al!.country,
                        data['country'],
                      ),
                      rowInfoContainer(
                        al!.project,
                        data['proyect'],
                      ),
                      rowInfoContainer(
                        al!.employment,
                        data['jobs'],
                      ),
                      rowInfoContainer(
                        al!.skills,
                        data['skill'],
                      ),

                      // 'title': 'Tinguar ',
                      // 'proyect': 'Generador de link',
                      // 'skill': 'Flutter, Dart',
                      // 'jobs': 'Freelancer',
                      // 'link': 'https://tiendas.tinguar.com/',
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          html.window.open(
                            data['link'],
                            data['proyect'],
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          color: const Color(0xffa0854e),
                          child: Text(
                            al!.seeProject.toUpperCase(),
                            style: StyleText.textStyleClass(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 30,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AssetsUtil.imgContainerMiniMinecraft,
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

Widget rowInfoContainer(String title, description) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 8.0,
      right: 8.0,
      top: 9.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 135.0,
          child: Text(
            title,
            style: StyleText.textStyleClass(
                fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            description,
            style: StyleText.textStyleClass(
                fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Widget iconWidget(IconData fontIcon, VoidCallback inkWell) {
  return InkWell(
    onTap: inkWell,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: FaIcon(
        fontIcon,
        color: Colors.white,
      ),
    ),
  );
}

class StyleText {
  static TextStyle textStyleClass(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontFamily: 'Minecraftia',
      fontSize: fontSize ?? 20.0,
      fontWeight: fontWeight ?? FontWeight.w100,
      color: color ?? Colors.white,
    );
  }
}

Widget containerOnpress(VoidCallback onPressed, String title) {
  return Stack(
    children: [
      Container(
        color: Colors.transparent,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                ),
                const SizedBox(width: 5.0),
                Text(
                title,
                  style: StyleText.textStyleClass(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 0,
        bottom: 0,
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
      Positioned(
        right: 0,
        top: 0,
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
      Positioned(
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: Container(
          height: 10,
          width: 10,
          color: Colors.brown,
        ),
      ),
    ],
  );
}
