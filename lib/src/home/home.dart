import "package:albertoguaman/src/model/model.dart";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:go_router/go_router.dart";
import "../utils/utils.dart";
import 'package:zwidget/zwidget.dart';
import "../widget/widget.dart";

final List<String> sections = [
  'Sobre Mí',
  'Proyectos',
  'Publicaciones',
  'Experiencia'
];

class HomeSrc extends StatefulWidget {
  const HomeSrc({super.key});

  @override
  State<HomeSrc> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<HomeSrc>
    with TickerProviderStateMixin {
  late List<bool> inHovered;
  late List<bool> inHoveredBook;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    inHovered = List<bool>.filled(infoProjectModel.length, false);
    inHoveredBook = List<bool>.filled(infoButtonModel.length, false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: UtilsColor.colorPink,
        backgroundColor: Colors.transparent,
        // elevation: 0,
        // centerTitle: true,
        // title: _buildPowered(),
        // actionsIconTheme: const IconThemeData(
        //   color: Colors.white,
        // ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: context.isMobile || context.isMobileLarge
          ? Container(
              width: context.screenWidth / 2,
              decoration: BoxDecoration(
                  color: UtilsColor.colorPrimaryDark,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(SizeUtils.m)),
              child: Column(
                children: [
                  SizedBox(height: SizeUtils.xl1),
                  buildAvatar(context, al, maxRadius: SizeUtils.xl),
                  SizedBox(width: SizeUtils.m),
                  buildRowName(context,
                      visibility: true,
                      visibilityNameW: true,
                      text: 'Alberto Guaman'.toUpperCase()),
                  SizedBox(height: SizeUtils.s1),
                  _buildSectionsColumn(context, sections),
                ],
              ),
            )
          : null,
      backgroundColor: UtilsColor.colorPrimaryDark,
      body: Responsive(
        mobile: SingleChildScrollView(
          controller: _scrollController,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SizedBox(height: SizeUtils.xl1),

              Animater3D(
                image: Image.asset(AssetsUtil.imgAlbertoGuaman),
              ),
              // buildAvatar3D(
              //   context,
              //   al,
              // ),
              // SizedBox(height: SizeUtils.xl1),
              // buildAvatar(context, al),
              SizedBox(width: SizeUtils.m),
              buildRowName(context),
              SizedBox(height: SizeUtils.xl),
              _buildSectionsRow(context, sections),
              SizedBox(height: SizeUtils.xl),
              _buildSectionContent('', sectionKeys['Sobre Mí']!),
              _buildAboutMe(al),
              _buildSectionContent('', sectionKeys['Proyectos']!),
              _buildProject(al, context),
              _buildSectionContent('', sectionKeys['Publicaciones']!),
              _buildPublications(al),
              _buildSectionContent('', sectionKeys['Experiencia']!),
              _buildExperience(al),
              footerData(al, context.screenWidth),
              SizedBox(height: SizeUtils.xl1),
            ],
          ),
        ),
        desktop: SingleChildScrollView(
          controller: _scrollController,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SizedBox(height: SizeUtils.xl1),
              SizedBox(
                height: context.screenHeight * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Animater3D(
                      image: Image.asset(AssetsUtil.imgAlbertoGuaman),
                    ),
                    // buildAvatar(context, al),
                    SizedBox(width: SizeUtils.l1),
                    buildRowName(context),
                  ],
                ),
              ),
              SizedBox(height: SizeUtils.l),
              _buildSectionsRow(context, sections),
              SizedBox(height: SizeUtils.l),

              _buildSectionContent('', sectionKeys['Sobre Mí']!),
              _buildAboutMe(al),
              _buildSectionContent('', sectionKeys['Proyectos']!),
              _buildProject(al, context),
              _buildSectionContent('', sectionKeys['Publicaciones']!),
              _buildPublications(al),
              _buildSectionContent('', sectionKeys['Experiencia']!),
              _buildExperience(al),
              // iconDataRow(),
              // SizedBox(height: SizeUtils.xl),
              footerData(al, context.screenWidth),
              SizedBox(height: SizeUtils.xl1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperience(AppLocalizations? al) {
    return ResponsiveCenter(
      child: _buildContainerInfo(
        al,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: infoExperienceModel.length,
          itemBuilder: (context, index) {
            final experience = infoExperienceModel[index];
            return Padding(
              padding:
                  EdgeInsets.symmetric(vertical: index != 1 ? 0 : SizeUtils.s),
              child: _buildCardInfo(
                  () {},
                  1.0,
                  Colors.transparent,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(experience.title.toUpperCase(),
                          style: StyleText.textPortfolio(
                            fontSize: TextStyleSize.textTitleSize(
                                context.screenWidth),
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: SizeUtils.m),
                      Text(experience.type,
                          style: StyleText.textPortfolio(
                            fontSize: TextStyleSize.textDescriptionSize(
                                context.screenWidth),
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: SizeUtils.m),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: experience.description.map((desc) {
                          return Text(
                            desc,
                            style: StyleText.textPortfolio(
                                fontSize: TextStyleSize.textDescriptionSize(
                                    context.screenWidth)),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: SizeUtils.s1),
                      linerSpace()
                    ],
                  ),
                  'url',
                  'urlTitle',
                  'view',
                  experience.data,
                  Colors.transparent,
                  [],
                  titleToolTip: true,
                  positioned: true,
                  elevation: true),
            );
          },
        ),
        color: Colors.transparent,
        title: al!.experience,
      ),
    );
  }

  Widget _buildPublications(AppLocalizations? al) {
    return ResponsiveCenter(
      child: _buildContainerInfo(
          al,
          ListView.builder(
            shrinkWrap: true,
            // padding: EdgeInsets.all(SizeUtils.m ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: infoBookModel.length,
            itemBuilder: (context, index) {
              final book = infoBookModel[index];
              if (kDebugMode) {
                print(index);
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: index != 1 ? 0 : SizeUtils.s),
                child: _buildCardInfo(
                  () {
                    setState(() {
                      inHoveredBook[index] = !inHoveredBook[index];
                    });
                  },
                  inHoveredBook[index] ? 0.2 : 1.0,
                  UtilsColor.colorSecondaryWhite,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.title,
                          style: StyleText.textPortfolio(
                            color: UtilsColor.colorPrimaryDark,
                            fontSize: TextStyleSize.textTitleSize(
                                context.screenWidth),
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: SizeUtils.m),
                      Text(
                        book.description,
                        maxLines: context.isDesktop ? 4 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: StyleText.textPortfolio(
                            color: UtilsColor.colorPrimaryDark,
                            fontSize: TextStyleSize.textDescriptionSize(
                                context.screenWidth)),
                      ),
                    ],
                  ),
                  book.buttonVoidCall,
                  book.buttonVoidCall,
                  book.buttonText,
                  '${index + 1}',
                  UtilsColor.colorPink,
                  [inHoveredBook[index]],
                ),
              );
            },
          ),
          title: 'Publicaciones',
          color: UtilsColor.colorPrimaryDark),
    );
  }

  Widget _buildProject(AppLocalizations? al, BuildContext context) {
    final int crossAxisCount = context.isDesktop
        ? 2
        : context.isTabletLarge
            ? 2
            : context.isTablet
                ? 2
                : context.isMobileLarge
                    ? 1
                    : 1;
    final double mainAxisExtent = context.isDesktop
        ? 156
        : context.isTabletLarge
            ? 150
            : context.isTablet
                ? 156
                : context.isMobileLarge
                    ? 135
                    : 150;

    return ResponsiveCenter(
        child: _buildContainerInfo(
      al,
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.all(SizeUtils.l),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisExtent: mainAxisExtent,
          crossAxisSpacing: SizeUtils.s1,
          mainAxisSpacing: SizeUtils.s1,
          childAspectRatio: 2,
        ),
        itemCount: infoProjectModel.length,
        itemBuilder: (context, index) {
          final project = infoProjectModel[index];
          return _buildCardInfo(() {
            setState(() {
              inHovered[index] = !inHovered[index];
            });
          },
              inHovered[index] ? 0.2 : 1.0,
              UtilsColor.colorYellow,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title,
                      style: StyleText.textPortfolio(
                        color: UtilsColor.colorPrimaryDark,
                        fontSize:
                            TextStyleSize.textTitleSize(context.screenWidth),
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: SizeUtils.m),
                  Text(
                    project.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: StyleText.textPortfolio(
                        color: UtilsColor.colorPrimaryDark,
                        fontSize: TextStyleSize.textDescriptionSize(
                            context.screenWidth)),
                  ),
                ],
              ),
              project.buttonVoidCall,
              project.buttonVoidCall,
              project.title,
              '${index + 1}',
              UtilsColor.colorBlue,
              [inHovered[index]]);
        },
      ),
      color: UtilsColor.colorPink,
      title: 'Proyectos'.toUpperCase(),
    ));
  }

  Widget _buildCardInfo(
    VoidCallback onTap,
    double opacity,
    Color color,
    Widget child,
    String url,
    String urlTitle,
    String view,
    String titleShape,
    Color colorShape,
    List<bool> listBool, {
    bool? titleToolTip = false,
    bool? positioned = false,
    bool? elevation = false,
  }) {
    return tooltipW(
      titleToolTip == false ? 'Más información' : '',
      GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 100),
              child: Card(
                color: color,
                elevation: elevation == false ? 4 : 0,
                child: Padding(
                  padding: EdgeInsets.all(SizeUtils.s),
                  child: child,
                ),
              ),
            ),
            if (listBool.isNotEmpty && listBool.any((boolValue) => boolValue))
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(SizeUtils.s),
                    child: containerBottom(
                        () => laucherURL(url), urlTitle, view,
                        padding: 0),
                  ),
                ),
              ),
            // ... (
            Positioned(
                top: -10,
                right: 0,
                child: Container(
                    padding: EdgeInsets.all(SizeUtils.m),
                    decoration: BoxDecoration(
                      color: colorShape,
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(titleShape,
                        style: StyleText.textPortfolio(
                            fontSize: positioned == false
                                ? SizeUtils.xl
                                : SizeUtils.l))))
          ],
        ),
      ),
    );
  }

  Widget _buildAboutMe(AppLocalizations? al) {
    return ResponsiveCenter(
      child: Column(
        children: [
          containerBottom(() {
            context.go('/bio');
          }, 'https://www.albertoguaman.com/bio', 'Enlaces Rapidos',
              width: double.infinity),
          _buildContainerInfo(
            al,
            Text(al!.descriptionAbout,
                style: StyleText.textPortfolio(
                  fontSize:
                      TextStyleSize.textDescriptionSize(context.screenWidth),
                )),
            title: 'sobre mi'.toUpperCase(),
          ),
          Row(
            children: [
              containerBottom(() => laucherURL('https://tunegocio.pro/AWcDD'),
                  '+593 99 860 2204', al.contacMe),
              containerBottom(
                  () => laucherURL(
                      'https://drive.google.com/file/d/1QY5pypA8L8R_j0ZkBpyzqWLi0oQf33Ej/view?usp=drive_link'),
                  'Google Driver',
                  'cv 2025'),
              Flexible(
                  flex: 1,
                  child: _buildContainerInfo(al, Container(),
                      height: SizeUtils.xlq)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContainerInfo(AppLocalizations? al, Widget child,
      {double? height, Color? color, String? title}) {
    return Padding(
      padding: EdgeInsets.all(SizeUtils.s),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: color ?? UtilsColor.colorBlue,
            border: Border.all(color: color ?? UtilsColor.colorBlue),
            borderRadius: BorderRadius.circular(SizeUtils.m)),
        child: Padding(
          padding: EdgeInsets.all(SizeUtils.s),
          child: Column(
            children: [
              Text(title ?? '',
                  style: StyleText.textPortfolio(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        TextStyleSize.textTitleSectionSize(context.screenWidth),
                  )),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionsRow(BuildContext context, List<String> sections) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sections
          .map(
            (section) => GestureDetector(
              onTap: () => _scrollToSection(section),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.s),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    section,
                    style: StyleText.textPortfolio(
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSectionsColumn(BuildContext context, List<String> sections) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sections
          .map(
            (section) => GestureDetector(
              onTap: () {
                _scrollToSection(section);
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(SizeUtils.s),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    section,
                    style: StyleText.textPortfolio(
                      fontSize:
                          TextStyleSize.textTitleSize(context.screenWidth),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSectionContent(String title, GlobalKey key) {
    return Container(
      key: key,
      child: Text(title,
          style: StyleText.textPortfolioDancingScript(
              fontWeight: FontWeight.w100,
              color: UtilsColor.colorSecondaryWhite,
              fontSize: SizeUtils.s1)),
    );
  }
}

Widget _buildPowered() {
  return tooltipW(
    'https://tinguar.com/',
    InkWell(
      onTap: () => laucherURL('https://tinguar.com/'),
      child: RichText(
        text: TextSpan(
          style: StyleText.textPortfolio(
              color: UtilsColor.colorPrimaryDark), // Default style
          children: <TextSpan>[
            TextSpan(text: 'Impulsado por '.toUpperCase()),
            TextSpan(
              text: 'Tinguar'.toUpperCase(),
              style: StyleText.textPortfolioDancingScript(),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildAvatar(BuildContext context, AppLocalizations? al,
    {double? maxRadius}) {
  return CircleAvatar(
    maxRadius: maxRadius ?? SizeUtils.xxl3,
    backgroundColor: UtilsColor.colorSecondaryWhite,
    backgroundImage: AssetImage(AssetsUtil.imgAlbertoGuaman),
  );
}

Widget buildRowName(
  BuildContext context, {
  bool? visibility = false,
  bool? visibilityNameW = false,
  String? text,
  double? fontSize,
}) {
  final al = AppLocalizations.of(context);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
    child: Column(
      children: [
        SizedBox(height: SizeUtils.s),
        Text(text ?? al!.helloWordIam.toUpperCase(),
            style: StyleText.textPortfolio(
              fontWeight: FontWeight.bold,
              color: UtilsColor.colorYellow,
              fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
            )),
        SizedBox(width: SizeUtils.m),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            visibilityNameW == false
                ? Text('Alberto Guaman'.toUpperCase(),
                    style: StyleText.textPortfolio(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize ??
                          TextStyleSize.textTitleSectionSize(
                              context.screenWidth),
                    ))
                : const SizedBox.shrink(),
          ],
        ),
        visibility == false ? iconDataRow() : Container()
      ],
    ),
  );
}

// Widget animatedText() {
//   return SizedBox(
//       child: DefaultTextStyle(
//     style: StyleText.textPortfolio(
//         fontWeight: FontWeight.bold,
//         fontSize: SizeUtils.l1,
//         colorBackgroundColor: UtilsColor.colorPinkSecondary),
//     child: AnimatedTextKit(
//       isRepeatingAnimation: false,
//       displayFullTextOnTap: true,
//       repeatForever: false,
//       animatedTexts: [
//         TyperAnimatedText(' Alberto Guaman'.toUpperCase(),
//             speed: Duration(milliseconds: SizeUtils.speed)),
//         // TyperAnimatedText(' Tecnólogo  en Sistemas'.toUpperCase(),
//         //     speed: Duration(milliseconds: SizeUtils.speed)),
//       ],
//       onTap: () {
//         if (kDebugMode) {
//           print("Tap Event");
//         }
//       },
//     ),
//   ));
// }
