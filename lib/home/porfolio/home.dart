import 'package:albertoguaman/models/models.dart';
import 'package:albertoguaman/utils/text.dart';
import 'package:albertoguaman/utils/utils.dart';
import 'package:albertoguaman/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePortfolio extends StatefulWidget {
  const HomePortfolio({super.key});

  @override
  State<HomePortfolio> createState() => _HomePortfolioState();
}

class _HomePortfolioState extends State<HomePortfolio> {
  late List<bool> inHovered;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // inHovered.addAll(List.filled(dataList.length, false));
    inHovered = List<bool>.filled(dataList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: UtilsColor.colorHomePrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: SizeUtils.l),
          child: Responsive(
            mobile: _buildLayout(
              context,
              al,
              isMobile: true,
              inHovered: inHovered,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            ),
            desktop: _buildLayout(
              context,
              al,
              isMobile: false,
              inHovered: inHovered,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
            ),
          ),
        ),
      ),
      floatingActionButton: CupertinoSwitchW(
        textStyle: StyleText.textStyleOriginal(color: UtilsColor.colorDarkGrey),
        style: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildLayout(
    BuildContext context,
    AppLocalizations? al, {
    required bool isMobile,
    required EdgeInsets padding,
    required List<bool> inHovered,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildContent(context, al, isMobile: isMobile),
        SizedBox(height: SizeUtils.l),
        Padding(
          padding: padding,
          child: _buildDescription(context, al!.descriptionAbout),
        ),
        SizedBox(height: SizeUtils.l),
        _buildRowIcon(al),
        SizedBox(height: SizeUtils.l),
        Padding(
          padding: padding,
          child: _buildTitleData(al.proyectRealized),
        ),
        SizedBox(height: SizeUtils.l),
        Padding(
          padding: padding,
          child: _buildGridProject(inHovered),
        ),
        SizedBox(height: SizeUtils.l),
        Padding(
          padding: padding,
          child: _buildTitleData(al.experience),
        ),
        SizedBox(height: SizeUtils.l)
      ],
    );
  }

  Widget _buildGridProject(List<bool> inHovered) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context)
              ? 2
              : Responsive.isMobile(context)
                  ? 1
                  : 2,
          childAspectRatio: 7 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: dataList.length > 4 ? 4 : dataList.length,
        itemBuilder: (_, index) {
          final dataReturn = dataList[index];
          final String? projectText = dataReturn['proyect'];
          return MouseRegion(
            onEnter: (_) {
              setState(() {
                inHovered[index] = true;
              });
            },
            onExit: (_) {
              setState(() {
                inHovered[index] = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print('click ${dataReturn['proyect']}');
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedOpacity(
                    opacity: inHovered[index] ? 0.3 : 1.0,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      decoration: BoxDecoration(
                        color: dataReturn['color'],
                        border: Border.all(),
                        borderRadius:
                            BorderRadius.all(Radius.circular(SizeUtils.s)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(SizeUtils.s),
                            child: ResponsiveText(
                              text: (index == 3 && projectText != null)
                                  ? projectText.toUpperCase()
                                  : projectText?.toUpperCase() ?? 'Sin título',
                              minSize: index == 3
                                  ? SizeUtils.xl
                                  : SizeUtils.s1, // 10
                              maxSize: index == 3
                                  ? SizeUtils.xxl2
                                  : SizeUtils.l, // 15
                              style: StyleText.textStyleOriginalDark(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (inHovered[index])
                    Positioned.fill(
                        child: Center(
                      child: Icon(
                        Icons.link,
                        color: UtilsColor.colorDarkGrey,
                        size: 100,
                      ),
                    ))
                ],
              ),
            ),
          );
        });
  }

  Widget _buildRowIconData(AppLocalizations? al) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget(FontAwesomeIcons.tiktok, () {
          if (kDebugMode) {
            print('linkeding');
          }
          html.window.open(
            'https://www.tiktok.com/@albertoguaman.com',
            'Tiktok',
          );
        }, message: 'Tiktok', color: UtilsColor.colorDarkGrey),
        iconWidget(FontAwesomeIcons.linkedin, () {
          if (kDebugMode) {
            print('linkeding');
          }

          html.window.open(
            'https://www.linkedin.com/in/albertoguaman/',
            'Linkedin',
          );
        }, message: 'Linkedin', color: UtilsColor.colorDarkGrey),
        iconWidget(FontAwesomeIcons.facebook, () {
          if (kDebugMode) {
            print('Facebook');
          }

          html.window.open(
            'https://www.facebook.com/albertoguamantinguar',
            'Facebook',
          );
        }, message: 'Facebook', color: UtilsColor.colorDarkGrey),
        iconWidget(FontAwesomeIcons.instagram, () {
          html.window.open(
            'https://www.instagram.com/albertoguamandev/',
            'Instagram',
          );
        }, message: 'Instagram', color: UtilsColor.colorDarkGrey),
      ],
    );
  }

  Widget _buildStackContainerProyect(
      BuildContext context, String number, Color colorNumber) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(SizeUtils.s)),
                border: Border.all(color: UtilsColor.colorDarkGrey)),
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeUtils.s,
                right: SizeUtils.xl,
                top: SizeUtils.s1,
                bottom: SizeUtils.m,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: SizeUtils.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sistema Arcano',
                      style: StyleText.textStyleOriginalDark(
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Descripcion de sistemas arcano',
                      style: StyleText.textStyleOriginalDark(
                        fontSize: null,
                        minFontSize: SizeUtils.s, // 15
                        maxFontSize: SizeUtils.l, // 20
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
                color: colorNumber,
                child: Padding(
                  padding: EdgeInsets.all(SizeUtils.m),
                  child: Text(
                    number,
                    style: StyleText.textStyleOriginalDark(
                      fontSize: null,
                      minFontSize: SizeUtils.l, // 10
                      maxFontSize: SizeUtils.l1, // 15
                      context: context,
                    ),
                  ),
                )))
      ],
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations? al,
      {required bool isMobile}) {
    final avatar = CircleAvatar(
      maxRadius: SizeUtils.xxl4,
      backgroundColor: UtilsColor.colorOriginalPorfolioW,
      backgroundImage: AssetImage(AssetsUtil.imgAlbertoGuaman),
    );

    final info = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: StyleText.textStyleOriginalDark(
                  fontWeight: FontWeight.bold,
                  fontSize: null,
                  minFontSize: SizeUtils.l2, // 30
                  maxFontSize: SizeUtils.xl, // 40
                  context: context,
                ), // Default style for all spans
                children: <TextSpan>[
                  const TextSpan(text: 'Saludos soy '),
                  TextSpan(
                    text: 'Alberto Guaman',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: UtilsColor.colorHomePrimaryGreen),
                  ),
                ],
              ),
            ),
            SizedBox(width: SizeUtils.m),
            Icon(
              Icons.verified,
              size: SizeUtils.xl,
              color: UtilsColor.colorBlue,
            ),
          ],
        ),
        SizedBox(height: SizeUtils.m),
        ResponsiveText(
          text: al!.administratorIt,
          minSize: SizeUtils.l, // 20
          maxSize: SizeUtils.l1, // 30
          style: StyleText.textStyleOriginalDark(),
        ),
        SizedBox(height: SizeUtils.s),
        _buildRowIconData(al)
      ],
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isMobile
          ? [
              avatar,
              SizedBox(height: SizeUtils.m),
              info,
            ]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  avatar,
                  SizedBox(width: SizeUtils.l2),
                  info,
                ],
              ),
            ],
    );
  }

  Widget _buildDescription(BuildContext context, String text) {
    return ResponsiveText(
      text: text,
      minSize: SizeUtils.l, // 20
      maxSize: SizeUtils.l, // 25
      style: StyleText.textStyleOriginalDark(),
    );
  }

  Widget _buildTitleData(String text) {
    return Column(
      children: [
        linerSpace(),
        ResponsiveText(
          text: text.toUpperCase(),
          minSize: SizeUtils.l1, // 30
          maxSize: SizeUtils.xxl3, // 35
          style: StyleText.textStyleOriginalDark(fontWeight: FontWeight.bold),
        ),
        linerSpace(),
      ],
    );
  }

  Widget _buildRowIcon(AppLocalizations? al) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContainerButtonWidget(
          al: al,
          text: al!.contacMe,
          onTap: () =>
              html.window.open('https://tunegocio.pro/G4YbU', 'WhastApp'),
          colorText: UtilsColor.colorOriginalW,
          message: 'WhastApp',
        ),
        SizedBox(width: SizeUtils.l),
        ContainerButtonWidget(
          al: al,
          text: 'CV - 2024',
          color: Colors.transparent,
          onTap: () {
            if (kDebugMode) {
              print('cv');
            }
          },
          message: al.view,
        ),
      ],
    );
  }
}
