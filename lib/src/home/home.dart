import 'dart:async';

import "package:albertoguaman/src/model/model.dart";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:albertoguaman/l10n/app_localizations.dart';
import "package:go_router/go_router.dart";
import "../utils/utils.dart";
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

/// Colores claros para la barra animada (fondo oscuro).
final List<Color> _animatedBarColors = [
  UtilsColor.colorYellow,
  UtilsColor.colorPink,
  UtilsColor.colorBlue,
  Colors.cyanAccent,
  Colors.greenAccent,
  Colors.orangeAccent,
];

class _PortfolioScreenState extends State<HomeSrc>
    with TickerProviderStateMixin {
  late List<bool> inHovered;
  late List<bool> inHoveredBook;

  final ScrollController _scrollController = ScrollController();
  Timer? _colorBarTimer;
  int _barColorIndex = 0;

  @override
  void initState() {
    super.initState();
    inHovered = List<bool>.filled(infoProjectModel.length, false);
    inHoveredBook = List<bool>.filled(infoButtonModel.length, false);
    _colorBarTimer = Timer.periodic(const Duration(milliseconds: 2500), (_) {
      if (mounted) {
        setState(() {
          _barColorIndex =
              (_barColorIndex + 1) % _animatedBarColors.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _colorBarTimer?.cancel();
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
      body: animatedBackground(
        Responsive(
          mobile: SingleChildScrollView(
            controller: _scrollController,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SizedBox(height: SizeUtils.xl1),
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
                buildRowName(context),
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
        this,
        particleCount: 110,
      ),
    );
  }

  Widget _buildExperience(AppLocalizations? al) {
    final grouped = <String, List<Experience>>{};
    for (final e in infoExperienceModel) {
      grouped.putIfAbsent(e.title, () => []).add(e);
    }
    final companies = grouped.keys.toList();

    return ResponsiveCenter(
      child: _buildContainerInfo(
        al,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: companies.length,
          itemBuilder: (context, companyIndex) {
            final companyName = companies[companyIndex];
            final experiences = grouped[companyName]!;
            final isTimeline = experiences.length > 1;

            if (isTimeline) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: companyIndex < companies.length - 1
                        ? SizeUtils.xl
                        : 0),
                child: _buildCompanyTimeline(
                    context, companyName, experiences),
              );
            }
            final experience = experiences.single;
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: companyIndex != 1 ? 0 : SizeUtils.s),
              child: _buildExperienceCard(experience),
            );
          },
        ),
        color: Colors.transparent,
        title: al!.experience,
      ),
    );
  }

  Widget _buildCompanyTimeline(
      BuildContext context, String companyName, List<Experience> experiences) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(companyName.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textTitleSize(context.screenWidth),
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: SizeUtils.l),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < experiences.length; i++) ...[
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UtilsColor.colorYellow,
                          border: Border.all(
                              color: UtilsColor.colorSecondaryWhite,
                              width: 2),
                        ),
                      ),
                      if (i < experiences.length - 1)
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 2,
                              color: UtilsColor.colorYellow,
                            ),
                          ),
                        ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: SizeUtils.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < experiences.length; i++) ...[
                      _buildTimelineExperienceContent(
                          context, experiences[i],
                          isLast: i == experiences.length - 1),
                      if (i < experiences.length - 1)
                        SizedBox(height: SizeUtils.xl),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineExperienceContent(
      BuildContext context, Experience experience,
      {bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(experience.type,
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
              fontWeight: FontWeight.bold,
              color: UtilsColor.colorYellow,
            )),
        SizedBox(height: SizeUtils.s),
        Text(experience.data,
            style: StyleText.textPortfolio(
              fontSize: TextStyleSize.textDescriptionSize(context.screenWidth),
            )),
        if (experience.stack != null && experience.stack!.isNotEmpty) ...[
          SizedBox(height: SizeUtils.m),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.s, vertical: SizeUtils.m),
            decoration: BoxDecoration(
              color: UtilsColor.colorYellow.withOpacity(0.15),
              borderRadius: BorderRadius.circular(SizeUtils.m),
              border: Border.all(color: UtilsColor.colorYellow, width: 1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stack: ',
                    style: StyleText.textPortfolio(
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth),
                      fontWeight: FontWeight.bold,
                      color: UtilsColor.colorYellow,
                    )),
                Expanded(
                  child: Text(experience.stack!,
                      style: StyleText.textPortfolio(
                        fontSize: TextStyleSize.textDescriptionSize(
                            context.screenWidth),
                        color: UtilsColor.colorYellow,
                      )),
                ),
              ],
            ),
          ),
        ],
        SizedBox(height: SizeUtils.m),
        ...experience.description.map((desc) => Padding(
              padding: EdgeInsets.only(bottom: SizeUtils.s),
              child: Text(desc,
                  style: StyleText.textPortfolio(
                      fontSize: TextStyleSize.textDescriptionSize(
                          context.screenWidth))),
            )),
        if (!isLast) ...[SizedBox(height: SizeUtils.s1), linerSpace()],
      ],
    );
  }

  Widget _buildExperienceCard(Experience experience) {
    return _buildCardInfo(
        () {},
        1.0,
        Colors.transparent,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(experience.title.toUpperCase(),
                style: StyleText.textPortfolio(
                  fontSize: TextStyleSize.textTitleSize(context.screenWidth),
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: SizeUtils.m),
            Text(experience.type,
                style: StyleText.textPortfolio(
                  fontSize: TextStyleSize.textDescriptionSize(
                      context.screenWidth),
                  fontWeight: FontWeight.bold,
                )),
            if (experience.stack != null &&
                experience.stack!.isNotEmpty) ...[
              SizedBox(height: SizeUtils.m),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.s, vertical: SizeUtils.m),
                decoration: BoxDecoration(
                  color: UtilsColor.colorYellow.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(SizeUtils.m),
                  border: Border.all(color: UtilsColor.colorYellow, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Stack: ',
                        style: StyleText.textPortfolio(
                          fontSize: TextStyleSize.textDescriptionSize(
                              context.screenWidth),
                          fontWeight: FontWeight.bold,
                          color: UtilsColor.colorYellow,
                        )),
                    Expanded(
                      child: Text(experience.stack!,
                          style: StyleText.textPortfolio(
                            fontSize: TextStyleSize.textDescriptionSize(
                                context.screenWidth),
                            color: UtilsColor.colorYellow,
                          )),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: SizeUtils.m),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: experience.description.map((desc) {
                return Text(desc,
                    style: StyleText.textPortfolio(
                        fontSize: TextStyleSize.textDescriptionSize(
                            context.screenWidth)));
              }).toList(),
            ),
            SizedBox(height: SizeUtils.s1),
            linerSpace(),
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
        elevation: true);
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

    final gridContent = GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
        return _buildCardInfo(
          () {
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
          [inHovered[index]],
        );
      },
    );

    return ResponsiveCenter(
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.s),
        child: Container(
          decoration: BoxDecoration(
            color: UtilsColor.colorPink,
            border: Border.all(color: UtilsColor.colorPink),
            borderRadius: BorderRadius.circular(SizeUtils.m),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              expansionTileTheme: ExpansionTileThemeData(
                iconColor: UtilsColor.colorSecondaryWhite,
                collapsedIconColor: UtilsColor.colorSecondaryWhite,
                textColor: UtilsColor.colorSecondaryWhite,
                collapsedTextColor: UtilsColor.colorSecondaryWhite,
              ),
            ),
            child: ExpansionTile(
              initiallyExpanded: false,
              tilePadding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.s, vertical: SizeUtils.s),
              title: Text(
                'Proyectos (${infoProjectModel.length})',
                style: StyleText.textPortfolio(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      TextStyleSize.textTitleSectionSize(context.screenWidth),
                  color: UtilsColor.colorSecondaryWhite,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: SizeUtils.s),
                child: Text(
                  'Clic para ver la lista de proyectos',
                  style: StyleText.textPortfolio(
                    fontSize: TextStyleSize.textDescriptionSize(
                        context.screenWidth),
                    color: UtilsColor.colorSecondaryWhite,
                  ),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeUtils.s),
                  child: gridContent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              containerBottom(() => laucherURL('https://wa.me/593992889078'),
                  '+593 99 288 9078', al.contacMe),
              containerBottom(
                  () => laucherURL(
                      'https://drive.google.com/file/d/18jFg4BXgPFWq1vjJT83cUB9OuJaEMYmH/view?usp=sharing'),
                  'Google Drive',
                  'cv 2026'),
              Flexible(
                  flex: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxH = constraints.maxHeight;
                      final maxW = constraints.maxWidth;
                      final height = maxH.isFinite && maxH > 0
                          ? maxH.clamp(0.0, SizeUtils.xlq)
                          : SizeUtils.xlq;
                      final color = _animatedBarColors[_barColorIndex];
                      return Padding(
                        padding: EdgeInsets.all(SizeUtils.s),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeInOut,
                          width: maxW,
                          height: height,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(color: color),
                            borderRadius:
                                BorderRadius.circular(SizeUtils.m),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(SizeUtils.s),
                            child: const SizedBox.shrink(),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContainerInfo(AppLocalizations? al, Widget child,
      {double? height, Color? color, String? title}) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title ?? '',
            style: StyleText.textPortfolio(
              fontWeight: FontWeight.bold,
              fontSize:
                  TextStyleSize.textTitleSectionSize(context.screenWidth),
            )),
        child,
      ],
    );
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
          child: height != null
              ? SingleChildScrollView(child: content)
              : content,
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
