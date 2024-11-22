import 'package:albertoguaman/utils/text.dart';
import 'package:albertoguaman/utils/utils.dart';
import 'package:albertoguaman/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePortfolio extends StatelessWidget {
  const HomePortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: UtilsColor.colorOriginalPorfolioP,
      appBar: AppBar(
        title: Text(
          'Bienvenido a mi Portafolio'.toUpperCase(),
          style: StyleText.textStyleOriginalDark(
            color: UtilsColor.colorDarkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: UtilsColor.colorOriginalPorfolioG,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: SizeUtils.l),
          child: Responsive(
            mobile: _buildLayout(
              context,
              al,
              isMobile: true,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            ),
            desktop: _buildLayout(
              context,
              al,
              isMobile: false,
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
        _buildRowIcon(al)
      ],
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations? al,
      {required bool isMobile}) {
    final avatar = CircleAvatar(
      maxRadius: SizeUtils.xxl2,
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
            Text(
              'Alberto Guaman',
              style: StyleText.textStyleOriginalDark(
                fontWeight: FontWeight.bold,
                fontSize: null,
                minFontSize: SizeUtils.l2, // 30
                maxFontSize: SizeUtils.xl, // 40
                context: context,
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
        ResponsiveText(
          text: al.webDeveloperAndDataAnalyst,
          minSize: SizeUtils.l, // 20
          maxSize: SizeUtils.l1, // 30
          style: StyleText.textStyleOriginalDark(),
        ),
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
                  SizedBox(width: SizeUtils.s),
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

  Widget _buildRowIcon(AppLocalizations? al) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        containerOnpress(() {
          html.window.open(
            'https://tunegocio.pro/G4YbU',
            'WhastApp',
          );
        }, al!.contacMe,
            activate: false,
            style: StyleText.textStyleOriginalDark(
                color: UtilsColor.colorOriginalPorfolioW)),
        iconWidget(FontAwesomeIcons.linkedin, () {
          if (kDebugMode) {
            print('linkeding');
          }

          html.window.open(
            'https://www.linkedin.com/in/albertoguaman/',
            'Linkedin',
          );
        }, color: UtilsColor.colorDarkGrey),
        iconWidget(FontAwesomeIcons.instagram, () {
          html.window.open(
            'https://www.instagram.com/albertoguamandev/',
            'Instagram',
          );
        }, color: UtilsColor.colorDarkGrey),
        iconWidget(FontAwesomeIcons.tiktok, () {
          if (kDebugMode) {
            print('linkeding');
          }
          html.window.open(
            'https://www.tiktok.com/@albertoguaman.com',
            'Tiktok',
          );
        }, color: UtilsColor.colorDarkGrey),
      ],
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final double minSize;
  final double maxSize;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ResponsiveText({
    Key? key,
    required this.text,
    required this.minSize,
    required this.maxSize,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculamos el tamaño del texto
    double calculatedFontSize =
        screenWidth * 0.05; // Ajusta 0.05 según tus necesidades
    double fontSize = calculatedFontSize.clamp(minSize, maxSize);

    return Text(
      text,
      style:
          style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize),
      textAlign: textAlign,
    );
  }
}
