import "package:albertoguaman/src/model/button.dart";
import "package:albertoguaman/src/model/model.dart";
import "package:albertoguaman/src/util/responsive.dart";
import "package:albertoguaman/src/widget/size_text.dart";
import "package:albertoguaman/utils/color.dart";
import "package:albertoguaman/utils/size.dart";
import "package:albertoguaman/utils/text.dart";
import "package:albertoguaman/widgets/container_responsive.dart";
import "package:albertoguaman/widgets/liner_space.dart";
import 'package:animated_text_kit/animated_text_kit.dart';
import "package:flutter/foundation.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "../../utils/assets.dart";
import "../util/util.dart";
import 'package:responsive_layout_grid/responsive_layout_grid.dart';

final List<String> sections = ['Sobre Mí', 'Proyectos'];

class HomeSrc extends StatefulWidget {
  const HomeSrc({super.key});

  @override
  State<HomeSrc> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<HomeSrc> {
  late List<bool> inHovered;

  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {
    'Sobre Mí': GlobalKey(),
    'Proyectos': GlobalKey(),
    'Experiencia': GlobalKey(),
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // inHovered.addAll(List.filled(dataList.length, false));
    inHovered = List<bool>.filled(infoProjectModel.length, false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      // Realiza el scroll asegurando que el texto quede justo en la parte superior de la pantalla
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment:
            0.0, // El texto debe estar en la parte superior de la pantalla
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final List<ProjectModel> projects = infoProjectModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: UtilsColor.colorPink,
        centerTitle: true,
        title: _buildPowered(),
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
                  _buildAvatar(context, al, maxRadius: SizeUtils.xl),
                  SizedBox(width: SizeUtils.m),
                  _buildRowName(context,
                      visibility: true, text: 'Alberto Guaman'.toUpperCase()),
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
              _buildAvatar(context, al),
              SizedBox(width: SizeUtils.m),
              _buildRowName(context),
              SizedBox(height: SizeUtils.xl),
              _buildSectionsRow(context, sections),
              SizedBox(height: SizeUtils.xl),
              _buildSectionContent('', sectionKeys['Sobre Mí']!),
              _buildAboutMe(al),
              _buildSectionContent('', sectionKeys['Proyectos']!),
              _buildProject(al, context),
              _buildSectionContent('', sectionKeys['Experiencia']!),
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
                    _buildAvatar(context, al),
                    SizedBox(width: SizeUtils.l1),
                    _buildRowName(context),
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
              _buildSectionContent('', sectionKeys['Experiencia']!),
            ],
          ),
        ),
      ),
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
        ? 125
        : context.isTabletLarge
            ? 125
            : context.isTablet
                ? 125
                : context.isMobileLarge
                    ? 125
                    : 125;

    return ResponsiveCenter(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildContainerInfo(
          al,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(SizeUtils.l),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: 125,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2,
            ),
            itemCount: infoProjectModel.length,
            itemBuilder: (context, index) {
              final project = infoProjectModel[index];
              return tooltipW(
                'Más información',
                GestureDetector(
                  onTap: () {
                    setState(() {
                      inHovered[index] = !inHovered[index];
                    });
                  },
                  child: Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: inHovered[index] ? 0.2 : 1.0,
                        duration: const Duration(milliseconds: 100),
                        child: Card(
                          color: UtilsColor.colorYellow,
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(SizeUtils.s),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(project.title,
                                    style: StyleText.textPortfolio(
                                      color: UtilsColor.colorPrimaryDark,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: SizeUtils.s),
                                Text(
                                  project.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleText.textPortfolio(
                                    color: UtilsColor.colorPrimaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (inHovered[index])
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(SizeUtils.s),
                            child: containerBottom(
                                () => laucherURL(project.buttonVoidCall),
                                project.title,
                                'Ver proyecto',
                                padding: 0),
                          ),
                        ),
                      Positioned(
                          top: -10,
                          right: 0,
                          child: Container(
                              padding: EdgeInsets.all(SizeUtils.m),
                              decoration: BoxDecoration(
                                color: UtilsColor.colorBlue,
                                shape: BoxShape.rectangle,
                              ),
                              child: Text('${index + 1}',
                                  style: StyleText.textPortfolio(
                                      fontSize: SizeUtils.xl))))
                    ],
                  ),
                ),
              );
            },
          ),
          color: UtilsColor.colorPink,
          title: 'Proyectos'.toUpperCase(),
        )
      ],
    ));
  }

  Widget _buildContainerGrid() {
    return Container(
      decoration: BoxDecoration(
          color: UtilsColor.colorSecondaryWhite,
          border: Border.all(),
          borderRadius: BorderRadius.circular(SizeUtils.m)),
      child: Text('adsd'),
    );
  }

  Widget _buildAboutMe(AppLocalizations? al) {
    return ResponsiveCenter(
      child: Column(
        children: [
          _buildContainerInfo(
            al,
            Text(al!.descriptionAbout,
                style: StyleText.textPortfolio(
                  fontSize: SizeUtils.l
                      .sizeScaled(context.screenWidth, minSize: SizeUtils.s1),
                  // colorBackgroundColor: UtilsColor.colorPinkSecondary,
                )),
            title: 'sobre mi'.toUpperCase(),
          ),
          Row(
            children: [
              containerBottom(() => laucherURL('https://tunegocio.pro/AWcDD'),
                  '+593 99 860 2204', 'contactame'),
              Flexible(
                  flex: 1,
                  child: _buildContainerInfo(al, Container(),
                      height: SizeUtils.xlq)),
              containerBottom(
                  () => laucherURL(
                      'https://drive.google.com/file/d/1kP70ATjZv5zFK-fHNsw4u5fQMZR7Erhd/view?usp=sharing'),
                  'Google Driver',
                  'cv 2024'),
            ],
          )
        ],
      ),
    );
  }

  Widget containerBottom(VoidCallback onTap, String message, String text,
      {Color? color, Color? colorBorder, double? padding}) {
    return Padding(
      padding: EdgeInsets.all(padding ?? SizeUtils.s),
      child: tooltipW(
          message,
          InkWell(
            hoverColor: Colors.transparent,
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: color ?? UtilsColor.colorSecondaryWhite,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(SizeUtils.m)),
              child: Padding(
                padding: EdgeInsets.all(SizeUtils.s),
                child: Text(
                  text.toUpperCase(),
                  style: StyleText.textPortfolio(
                      fontSize: SizeUtils.s1,
                      fontWeight: FontWeight.w500,
                      color: UtilsColor.colorPrimaryDark),
                ),
              ),
            ),
          )),
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
            border: Border.all(),
            borderRadius: BorderRadius.circular(SizeUtils.m)),
        child: Padding(
          padding: EdgeInsets.all(SizeUtils.s),
          child: Column(
            children: [
              Text(title ?? '',
                  style: StyleText.textPortfolio(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeUtils.xl1
                        .sizeScaled(context.screenWidth, minSize: SizeUtils.xl),
                    // colorBackgroundColor: UtilsColor.colorPinkSecondary,
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
                      fontSize: SizeUtils.l1.sizeScaled(
                        context.screenWidth,
                        minSize: SizeUtils.s1,
                      ),
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
                      fontSize: SizeUtils.l1.sizeScaled(
                        context.screenWidth,
                        minSize: SizeUtils.l,
                      ),
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

Widget _buildAvatar(BuildContext context, AppLocalizations? al,
    {double? maxRadius}) {
  return CircleAvatar(
    maxRadius: maxRadius ?? SizeUtils.xxl3,
    backgroundColor: UtilsColor.colorOriginalPorfolioW,
    backgroundImage: AssetImage(AssetsUtil.imgAlbertoGuaman),
  );
}

Widget _buildRowName(
  BuildContext context, {
  bool? visibility = false,
  String? text,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
    child: Column(
      children: [
        SizedBox(height: SizeUtils.s),
        Text(text ?? '¡Hola, Mundo! Yo soy'.toUpperCase(),
            style: StyleText.textPortfolio(
              fontWeight: FontWeight.bold,
              color: UtilsColor.colorYellow,
              fontSize: SizeUtils.l1
                  .sizeScaled(context.screenWidth, minSize: SizeUtils.s1),
              // colorBackgroundColor: UtilsColor.colorPinkSecondary,
            )),
        SizedBox(width: SizeUtils.m),
        visibility == false
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Alberto Guaman'.toUpperCase(),
                      style: StyleText.textPortfolio(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeUtils.xl1.sizeScaled(context.screenWidth,
                            minSize: SizeUtils.xl),
                        // colorBackgroundColor: UtilsColor.colorPinkSecondary,
                      )),
                  // SizedBox(width: SizeUtils.m),
                  // Icon(
                  //   Icons.verified,
                  //   size: SizeUtils.xl,
                  //   color: UtilsColor.colorBlue,
                  // ),
                  // animatedText(),
                ],
              )
            : Container(),
        visibility == false
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: SizeUtils.s1,
                  runSpacing: SizeUtils.s1,
                  children: infoButtonModel.map((button) {
                    return tooltipW(
                        button.url,
                        Material(
                          color: UtilsColor.colorSecondaryWhite,
                          shape: const CircleBorder(),
                          child: IconButton(
                            icon: FaIcon(
                              button.icon,
                              color: UtilsColor.colorDarkPrimary,
                              size: SizeUtils.l2,
                            ),
                            onPressed: () => laucherURL(button.url),
                            hoverColor: UtilsColor.colorPinkSecondary,
                          ),
                        ));
                  }).toList(),
                ),
              )
            : Container()
      ],
    ),
  );
}

Widget tooltipW(String message, Widget child) {
  return Tooltip(
    padding: EdgeInsets.all(SizeUtils.m),
    message: message,
    textStyle: StyleText.textPortfolio(fontSize: SizeUtils.s1),
    margin: EdgeInsets.all(SizeUtils.m),
    decoration: BoxDecoration(
        color: UtilsColor.colorPrimaryDark,
        border: Border.all(color: UtilsColor.colorSecondaryWhite),
        borderRadius: BorderRadius.circular(SizeUtils.m)),
    child: child,
  );
}

//
// class PortfolioScreen extends StatefulWidget {
//   const PortfolioScreen({super.key});
//
//   @override
//   State<PortfolioScreen> createState() => _PortfolioScreenState();
// }
//
// class _PortfolioScreenState extends State<PortfolioScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final List<String> tabs = ['Portafolio', 'Resumen', 'Contáctanos'];
//   late List<Widget> screens;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabs.length, vsync: this);
//
//     screens = [
//       ListView.builder(
//           shrinkWrap: true,
//           // physics: NeverScrollableScrollPhysics(),
//           itemCount: infoProjectModel.length,
//           itemBuilder: (context, index) {
//             final infoProject = infoProjectModel[index];
//             return Responsive(
//                 mobile: Padding(
//                   padding: EdgeInsets.all(SizeUtils.s1),
//                   child: Column(
//                     children: [
//                       photoProject(infoProject.photo),
//                       _buildInfoProject(infoProject, child: Container()),
//                       linerSpace(),
//                     ],
//                   ),
//                 ),
//                 desktop: Column(
//                   children: [
//                     _buildInfoProject(infoProject),
//                     SizedBox(height: SizeUtils.m),
//                     linerSpace(),
//                     SizedBox(height: SizeUtils.m),
//                   ],
//                 ));
//           }),
//       const Placeholder(color: Colors.orange),
//       const Placeholder(color: Colors.cyanAccent),
//     ];
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final al = AppLocalizations.of(context);
//     return Responsive(
//       mobile: Column(
//         children: [
//           _buildTabBar(),
//           Expanded(
//               child: TabBarView(controller: _tabController, children: screens)),
//         ],
//       ),
//       tablet: Column(
//         children: [
//           _buildTabBar(),
//           Expanded(
//               child: TabBarView(controller: _tabController, children: screens)),
//         ],
//       ),
//       desktop: Row(
//         children: [
//           Flexible(
//             flex: 3,
//             child: SingleChildScrollView(
//               controller: ScrollController(),
//               child: infoData(
//                 al!,
//                 context,
//               ),
//             ),
//           ),
//           VerticalDivider(color: UtilsColor.colorDarkPrimary, width: 1),
//           Flexible(
//             flex: 6,
//             child: Column(
//               children: [
//                 _buildTabBar(), // TabBar para pantallas grandes
//                 Expanded(
//                     child: TabBarView(
//                         controller: _tabController, children: screens)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoProject(ProjectModel infoProject, {Widget? child}) {
//     return Responsive(
//       mobile: SizedBox(
//         height: 275.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             child ?? photoProject(infoProject.photo),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: SizeUtils.m),
//                 Text(
//                   infoProject.type.toUpperCase(),
//                   style: StyleText.textPortfolio(fontSize: SizeUtils.s1),
//                 ),
//                 SizedBox(height: SizeUtils.m),
//                 Text(
//                   infoProject.title,
//                   style: StyleText.textPortfolio(fontSize: SizeUtils.l2),
//                 ),
//                 SizedBox(
//                   width: context.screenWidth / 2.5,
//                   child: Text(
//                     infoProject.description,
//                     style: StyleText.textPortfolio(
//                         fontWeight: FontWeight.w100,
//                         color: UtilsColor.colorBrownSecondary),
//                   ),
//                 ),
//                 const Spacer(),
//                 containerBottom(() {}, infoProject.buttonText,
//                     color: UtilsColor.colorPinkPrimary,
//                     colorBorder: UtilsColor.colorDarkPrimary),
//                 SizedBox(height: SizeUtils.s1),
//               ],
//             ),
//           ],
//         ),
//       ),
//       desktop: Padding(
//         padding: EdgeInsets.all(SizeUtils.s1),
//         child: SizedBox(
//           height: 300.0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               child ?? photoProject(infoProject.photo),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       infoProject.type.toUpperCase(),
//                       style: StyleText.textPortfolio(fontSize: SizeUtils.s1),
//                     ),
//                     SizedBox(height: SizeUtils.m),
//                     Text(
//                       infoProject.title,
//                       style: StyleText.textPortfolio(fontSize: SizeUtils.l2),
//                     ),
//                     SizedBox(
//                       width: context.screenWidth / 5,
//                       child: Text(
//                         infoProject.description,
//                         style: StyleText.textPortfolio(
//                             fontWeight: FontWeight.w100,
//                             color: UtilsColor.colorBrownSecondary),
//                       ),
//                     ),
//                     const Spacer(),
//                     containerBottom(() {}, infoProject.buttonText,
//                         color: UtilsColor.colorPinkPrimary,
//                         colorBorder: UtilsColor.colorDarkPrimary)
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabBar() {
//     return TabBar(
//       controller: _tabController,
//       tabs: List.generate(
//         tabs.length,
//         (index) => Tab(
//           child: Text(
//             tabs[index].toUpperCase(),
//             style: StyleText.textPortfolio(
//               fontWeight: FontWeight.bold,
//               fontSize: SizeUtils.s1 + 3,
//               color: UtilsColor.colorDarkPrimary,
//             ),
//           ),
//         ),
//       ),
//       indicatorColor: UtilsColor.colorDarkPrimary,
//       indicatorWeight: 3.0,
//     );
//   }
//
// // class PortfolioScreen extends StatefulWidget {
// //   const PortfolioScreen({super.key});
// //
// //   @override
// //   State<PortfolioScreen> createState() => _PortfolioScreenState();
// // }
// //
// // class _PortfolioScreenState extends State<PortfolioScreen> {
// //   int _currentIndex = 0;
// //   final List<String> tabs = [' portafolio ', 'Resumen', 'contactanos'];
// //
// //   final List<Widget> screens = [
// //     ListView.builder(
// //         shrinkWrap: true,
// //         physics: NeverScrollableScrollPhysics(),
// //         itemCount: infoProjectModel.length,
// //         itemBuilder: (context, index) {
// //           final infoProject = infoProjectModel[index];
// //           return Responsive(
// //               mobile: Padding(
// //                 padding: EdgeInsets.all(SizeUtils.s1),
// //                 child: Column(
// //                   children: [
// //                     photoProject(infoProject.photo),
// //                   ],
// //                 ),
// //               ),
// //               desktop: Column(
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.all(SizeUtils.s1),
// //                     child: SizedBox(
// //                       height: 300.0,
// //                       child: Row(
// //                         children: [
// //                           photoProject(infoProject.photo),
// //                           Padding(
// //                             padding:
// //                                 EdgeInsets.symmetric(horizontal: SizeUtils.s1),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text(
// //                                   infoProject.type.toUpperCase(),
// //                                   style: StyleText.textPortfolio(
// //                                       fontSize: SizeUtils.s1),
// //                                 ),
// //                                 SizedBox(height: SizeUtils.m),
// //                                 Text(
// //                                   infoProject.title,
// //                                   style: StyleText.textPortfolio(
// //                                       fontSize: SizeUtils.l2),
// //                                 ),
// //                                 SizedBox(
// //                                   width: context.screenWidth / 5,
// //                                   child: Text(
// //                                     infoProject.description,
// //                                     style: StyleText.textPortfolio(
// //                                         fontWeight: FontWeight.w100,
// //                                         color: UtilsColor.colorBrownSecondary),
// //                                   ),
// //                                 ),
// //                                 // Expanded (child: Container(),),
// //                                 const Spacer(),
// //                                 containerBottom(() {}, infoProject.buttonText,
// //                                     color: UtilsColor.colorPinkPrimary,
// //                                     colorBorder: UtilsColor.colorDarkPrimary)
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(height: SizeUtils.m),
// //                   linerSpace(),
// //                   SizedBox(height: SizeUtils.m),
// //                 ],
// //               ));
// //         }),
// //     Container(),
// //     Center(
// //         child:
// //             Text('Contenido de Pantalla 3', style: StyleText.textPortfolio())),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final al = AppLocalizations.of(context);
// //
// //     return Responsive(
// //       mobile: Column(
// //         children: [infoData(al!, context)],
// //       ),
// //       mobileLarge: Column(
// //         children: [infoData(al, context)],
// //       ),
// //       tablet: Column(
// //         children: [
// //           Expanded(
// //             child: infoDataScreen(),
// //           )
// //         ],
// //       ),
// //       desktop: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           context.screenWidth > 1300
// //               ? SingleChildScrollView(
// //                   child: SizedBox(width: 400.0, child: infoData(al, context)))
// //               : Container(),
// //           linerSpaceV(context),
// //           Flexible(flex: 4, child: infoDataScreen())
// //         ],
// //       ),
// //     );
// //   }
// //
//
// // }
// //
//   Widget photoProject(String photo) {
//     return Container(
//         alignment: AlignmentDirectional(1, 1),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: UtilsColor.colorDarkPrimary, // Set border color to red
//             width: 1, // Set border width
//           ),
//         ),
//         child: Image.asset(
//           photo,
//           scale: 1,
//         ));
//   }
//
// //
//   Widget infoData(AppLocalizations al, BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(height: SizeUtils.s1),
//         rowInfoName(),
//         SizedBox(height: SizeUtils.s1),
//         // Padding(
//         //     padding: EdgeInsets.symmetric(
//         //         horizontal: SizeUtils.s1, vertical: SizeUtils.s),
//         //     child: infoDescription(al)),
//         // SizedBox(height: SizeUtils.s1),
//         // linerSpace(),
//         SizedBox(height: SizeUtils.s1),
//         photoUser(),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
//           child: Wrap(
//             alignment: WrapAlignment.start,
//             spacing: SizeUtils.s1,
//             runSpacing: SizeUtils.s1,
//             children: infoButtonModel.map((button) {
//               return Material(
//                 color: UtilsColor.colorPinkSecondary, // Fondo rojo
//                 shape: const CircleBorder(), // Forma circular
//                 child: IconButton(
//                   icon: FaIcon(
//                     button.icon,
//                     color: UtilsColor.colorDarkPrimary,
//                     size: SizeUtils.l2,
//                   ),
//                   onPressed: () => laucherURL(button.url),
//                   hoverColor: UtilsColor.colorPinkPrimary,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: SizeUtils.s1),
//       ],
//     );
//   }
//
// //

//
// //
Widget animatedText() {
  return SizedBox(
      child: DefaultTextStyle(
    style: StyleText.textPortfolio(
        fontWeight: FontWeight.bold,
        fontSize: SizeUtils.l1,
        colorBackgroundColor: UtilsColor.colorPinkSecondary),
    child: AnimatedTextKit(
      isRepeatingAnimation: false,
      displayFullTextOnTap: true,
      repeatForever: false,
      animatedTexts: [
        TyperAnimatedText(' Alberto Guaman'.toUpperCase(),
            speed: Duration(milliseconds: SizeUtils.speed)),
        // TyperAnimatedText(' Tecnólogo  en Sistemas'.toUpperCase(),
        //     speed: Duration(milliseconds: SizeUtils.speed)),
      ],
      onTap: () {
        if (kDebugMode) {
          print("Tap Event");
        }
      },
    ),
  ));
}
//
// //
//   Widget infoDescription(AppLocalizations al) {
//     return Text(al.descriptionAbout, style: StyleText.textPortfolio());
//   }
//
//   Widget photoUser() {
//     return Padding(
//       padding: EdgeInsets.all(SizeUtils.s1),
//       child: const Placeholder(),
//     );
//   }
//
//   Widget containerBottom(
//     VoidCallback onTap,
//     String text, {
//     Color? color,
//     Color? colorBorder,
//   }) {
//     return InkWell(
//       hoverColor: Colors.transparent,
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//             color: color ?? UtilsColor.colorPinkSecondary,
//             border: Border.all(
//               color: colorBorder ?? UtilsColor.colorPinkSecondary,
//             ),
//             borderRadius: BorderRadius.circular(SizeUtils.s1)),
//         child: Padding(
//           padding: EdgeInsets.all(SizeUtils.s),
//           child: Text(
//             text.toUpperCase(),
//             style: StyleText.textPortfolio(
//               fontSize: SizeUtils.s1,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // class DiagonalClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     final Path path = Path();
// //     path.moveTo(0, 0); // Punto inicial (esquina superior izquierda)
// //     path.lineTo(size.width - 40, 0); // Línea superior
// //     path.lineTo(size.width, size.height); // Diagonal al borde inferior derecho
// //     path.lineTo(0, size.height); // Línea inferior
// //     path.close(); // Cerrar el camino
// //     return path;
// //   }
// //
// //   @override
// //   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
// //     return false; // No se necesita recalcular el clip a menos que cambie el diseño
// //   }
// // }
//
// //   containerBottom(
// //   () => laucherURL(button.url),
// //   button.name,
// // );
//
// //
// // Padding(
// //     padding: EdgeInsets.symmetric(horizontal: SizeUtils.s1),
// //     child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: infoButtonModel.map((button) {
// //         return containerBottom(() => laucherURL(button.url), button.name);
// //       }).toList(),
// //     )),
