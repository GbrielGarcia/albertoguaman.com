import 'dart:math';
import 'package:albertoguaman/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

import '../../widgets/container_onpress.dart';
import '../../widgets/cupertino_switch.dart';
import '../../widgets/icon.dart';

class OriginalPorfolio extends StatelessWidget {
  const OriginalPorfolio({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UtilsColor.colorOriginalPorfolioB,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [                const SizedBox(height: 30.0),

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
                                  style: StyleText.textStyleOriginal(
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
                              style: StyleText.textStyleOriginal(),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              al!.webDeveloperAndDataAnalyst,
                              style: StyleText.textStyleOriginal(),
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
                                  style: StyleText.textStyleOriginal(
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
                              style: StyleText.textStyleOriginal(),
                            ),
                            Text(
                              al!.webDeveloperAndDataAnalyst,
                              style: StyleText.textStyleOriginal(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
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
                  }, al!.contacMe,
                      activate: false, style: StyleText.textStyleOriginal()),
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
                    style: StyleText.textStyleOriginal(),
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
                style: StyleText.textStyleOriginal(
                  fontSize: Responsive.isDesktop(context) ? 75 : 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40.0),
              DynamicContainersList(
                dataList: dataList,
                style: 1,
              ),
              const SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
      floatingActionButton: CupertinoSwitchW(
        textStyle: StyleText.textStyleOriginal(
            color: UtilsColor.colorOriginalPorfolioB),
        style: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

//
// class OriginalPorfolio extends StatefulWidget {
//   const OriginalPorfolio({super.key});
//
//   @override
//   State<OriginalPorfolio> createState() => _OriginalPorfolioState();
// }
//
// class _OriginalPorfolioState extends State<OriginalPorfolio> {
//   @override
//   Widget build(BuildContext context) {
//     final al = AppLocalizations.of(context);
//
//     return Scaffold(
//       backgroundColor: UtilsColor.colorOriginalPorfolio,
//       body: const HomeOriginal(),
//     );
//   }
// }
//
// class HomeOriginal extends StatefulWidget {
//   const HomeOriginal({super.key});
//
//   @override
//   State<HomeOriginal> createState() => _HomeOriginalState();
// }
//
// class _HomeOriginalState extends State<HomeOriginal> {
//   double top = 50.0;
//   double left = 50.0;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final Random _random = Random();
//
//     final double textScaleFactor = size.width / 400;
//
//     final double horizontal = 30.0;
//
//     final itemCount = portafolioItems.length;
//     final itemHeight = itemCount > 0 ? (size.height - 20) / itemCount : 100.0;
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: Responsive.isDesktop(context)
//             ? const EdgeInsets.all(100.0)
//             : Responsive.isTablet(context)
//                 ? const EdgeInsets.all(50.0)
//                 : const EdgeInsets.only(
//                     top: 50.0,
//                     bottom: 50,
//                     left: 20.0,
//                     right: 20.0,
//                   ),
//         child: containerBorder(
//           top: true,
//           bottom: true,
//           left: true,
//           right: true,
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: [
//                   containerBorder(
//                     right: true,
//                     width: Responsive.isDesktop(context)
//                         ? (size.width - 154) / 2
//                         : Responsive.isTablet(context)
//                             ? size.width - 154
//                             : size.width - 42,
//                     height: (size.width - 50) * 0.4,
//                     child: Column(
//                       children: [
//                         containerBorder(
//                           bottom: true,
//                           color: UtilsColor.colorOriginalPorfolioG,
//                           width: size.width,
//                           height: Responsive.isDesktop(context)
//                               ? 50
//                               : Responsive.isTablet(context)
//                                   ? 50
//                                   : 20,
//                           child: Padding(
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: horizontal),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Sobre mi'.toUpperCase(),
//                                   style: StyleText.textStyleOriginal(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Expanded(child: Container()),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: horizontal),
//                           child: RichText(
//                             text: TextSpan(
//                               style: StyleText.textStyleOriginal(
//                                   fontSize: 15.0 * textScaleFactor,
//                                   fontWeight: FontWeight.bold),
//                               children: const <TextSpan>[
//                                 TextSpan(text: 'Hola,soy '),
//                                 TextSpan(text: 'Alberto Guaman '),
//                                 TextSpan(
//                                   text: 'bienvenido a mi portafolio',
//                                   style: TextStyle(
//                                     decoration: TextDecoration.underline,
//                                     decorationColor:
//                                         Colors.green, // Color de la franja
//                                     decorationThickness:
//                                         3.0, // Grosor de la franja
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         const SizedBox(height: 20.0),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: horizontal),
//                           child: Text(
//                               'Freelancer con 2 años de experiencia en desarrollo de apps multiplataforma con flutter, también cuento con 3 años de experiencia en administración ti, soporte, y actualmente me estoy especializando en analista de datos.',
//                               style: StyleText.textStyleOriginal(
//                                 fontSize: 9 * textScaleFactor,
//                               )),
//                         ),
//                         Expanded(child: Container()),
//                         containerBorder(
//                           top: true,
//                           bottom: true,
//                           width: size.width,
//                           height: 50.0,
//                           color: UtilsColor.colorOriginalPorfolioP,
//                           child: Padding(
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: horizontal),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'descargar mi curriculum vitae'.toUpperCase(),
//                                   style: StyleText.textStyleOriginal(
//                                       fontSize: 7 * textScaleFactor),
//                                 ),
//                                 const SizedBox(width: 10.0),
//                                 const Icon(Icons.arrow_circle_right_outlined),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               containerBorder(
//                   bottom: true,
//                   width: size.width,
//                   height: 50.0,
//                   child: Container()),
//               containerBorder(
//                 bottom: true,
//                 width: size.width,
//                 height: 50.0,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: horizontal),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Portafolio'.toUpperCase(),
//                         style: StyleText.textStyleOriginal(
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               containerBorder(
//                 height: size.height,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (var item in portafolioItems)
//                       containerBorder(
//                         width: size.width,
//                         height: itemHeight,
//                         child: containerBorder(
//                             color: item.color,
//                             child: InkWell(
//                               onTap: () {
//                                 if (item.url.isNotEmpty) {
//                                   launchUrl(item.url);
//                                 }
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: horizontal),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 10.0),
//                                     Text(item.name),
//                                     Text(item.description),
//                                     Text(
//                                         'Tecnología: ${item.tecnology.join(', ')}'),
//                                   ],
//                                 ),
//                               ),
//                             )),
//                       ),
//                   ],
//                 ),
//               ),
//               containerBorder(
//                   height: 50.0,
//                   color: UtilsColor.colorOriginalPorfolioB,
//                   child: Container()),
//               containerBorder(
//                 width: size.width,
//                 height: 50.0,
//                 child: Container(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> launchUrl(String url) async {
//   final Uri uri = Uri.parse(url);
//   try {
//     if (kIsWeb) {
//       html.window.open(url, '_blank');
//     } else if (await url_launcher.canLaunchUrl(uri)) {
//       await url_launcher.launchUrl(uri,
//           mode: url_launcher.LaunchMode.externalApplication);
//     } else {
//       throw 'Error $url';
//     }
//   } catch (e) {
//     if (kDebugMode) {
//       print('Error ${e}');
//     }
//   }
// }
//
// class PortafolioItem {
//   final String company;
//   final String name;
//   final String description;
//   final List<String> tecnology;
//   final String logo;
//   final String url;
//   final Color color;
//
//   PortafolioItem({
//     required this.company,
//     required this.name,
//     required this.description,
//     required this.tecnology,
//     required this.logo,
//     required this.url,
//     required this.color,
//   });
// }
//
// final List<PortafolioItem> portafolioItems = [
//   PortafolioItem(
//     company: 'Tinguar',
//     name: 'Tu enlace',
//     description: 'Crear, gestiona de manera sencilla tus enlaces de whatsapp.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceTinguar,
//     url:
//         'https://play.google.com/store/apps/details?id=com.tinguardevtechnology.generador_acortador_whatsapp',
//     color: UtilsColor.colorOriginalPorfolioG,
//   ),
//   PortafolioItem(
//     company: 'Sciedtec',
//     name: 'Cerfificados automaticos.',
//     description:
//         'Generador de certificados mediante csv y diseños personalizados.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceSciedtec,
//     url: '',
//     color: UtilsColor.colorOriginalPorfolio,
//   ),
//   PortafolioItem(
//     company: 'Tinguar',
//     name: 'Tu enlace',
//     description: 'Crear, gestiona de manera sencilla tus enlaces de whatsapp.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceTinguar,
//     url:
//         'https://play.google.com/store/apps/details?id=com.tinguardevtechnology.generador_acortador_whatsapp',
//     color: UtilsColor.colorOriginalPorfolioG,
//   ),
//   PortafolioItem(
//     company: 'Sciedtec',
//     name: 'Cerfificados automaticos.',
//     description:
//         'Generador de certificados mediante csv y diseños personalizados.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceSciedtec,
//     url: '',
//     color: UtilsColor.colorOriginalPorfolio,
//   ),
//   PortafolioItem(
//     company: 'Tinguar',
//     name: 'Tu enlace',
//     description: 'Crear, gestiona de manera sencilla tus enlaces de whatsapp.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceTinguar,
//     url:
//         'https://play.google.com/store/apps/details?id=com.tinguardevtechnology.generador_acortador_whatsapp',
//     color: UtilsColor.colorOriginalPorfolioG,
//   ),
//   PortafolioItem(
//     company: 'Sciedtec',
//     name: 'Cerfificados automaticos.',
//     description:
//         'Generador de certificados mediante csv y diseños personalizados.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceSciedtec,
//     url: '',
//     color: UtilsColor.colorOriginalPorfolio,
//   ),
//   PortafolioItem(
//     company: 'Tinguar',
//     name: 'Tu enlace',
//     description: 'Crear, gestiona de manera sencilla tus enlaces de whatsapp.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceTinguar,
//     url:
//         'https://play.google.com/store/apps/details?id=com.tinguardevtechnology.generador_acortador_whatsapp',
//     color: UtilsColor.colorOriginalPorfolioG,
//   ),
//   PortafolioItem(
//     company: 'Sciedtec',
//     name: 'Cerfificados automaticos.',
//     description:
//         'Generador de certificados mediante csv y diseños personalizados.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceSciedtec,
//     url: '',
//     color: UtilsColor.colorOriginalPorfolio,
//   ),
//   PortafolioItem(
//     company: 'Tinguar',
//     name: 'Tu enlace',
//     description: 'Crear, gestiona de manera sencilla tus enlaces de whatsapp.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceTinguar,
//     url:
//         'https://play.google.com/store/apps/details?id=com.tinguardevtechnology.generador_acortador_whatsapp',
//     color: UtilsColor.colorOriginalPorfolioG,
//   ),
//   PortafolioItem(
//     company: 'Sciedtec',
//     name: 'Cerfificados automaticos.',
//     description:
//         'Generador de certificados mediante csv y diseños personalizados.',
//     tecnology: ['Flutter, Dart, Firebase,'],
//     logo: AssetsUtil.imgProyectLogoTuEnlaceSciedtec,
//     url: '',
//     color: UtilsColor.colorOriginalPorfolio,
//   ),
// ];
//
// Widget containerBorder(
//     {required Widget child,
//     bool? top,
//     bool? right,
//     bool? bottom,
//     bool? left,
//     double? width,
//     double? height,
//     Color? color}) {
//   return Container(
//     width: width,
//     height: height,
//     decoration: BoxDecoration(
//       color: color ?? Colors.transparent,
//       border: Border(
//         top: top == true
//             ? const BorderSide(color: Colors.black)
//             : BorderSide.none,
//         right: right == true
//             ? const BorderSide(color: Colors.black)
//             : BorderSide.none,
//         bottom: bottom == true
//             ? const BorderSide(color: Colors.black)
//             : BorderSide.none,
//         left: left == true
//             ? const BorderSide(color: Colors.black)
//             : BorderSide.none,
//       ),
//     ),
//     child: child,
//   );
// }
//
// // containerBorder(
// //   bottom: true,
// //   width: (size.width - 250) / 2,
// //   height: (size.width - 50) * 0.4,
// //   child: StaggeredGrid.count(
// //     crossAxisCount: 5,
// //     mainAxisSpacing: 4.0,
// //     crossAxisSpacing: 4.0,
// //     children: List.generate(20, (index) {
// //       return StaggeredGridTile.count(
// //         crossAxisCellCount: _random.nextInt(2) + 1,
// //         mainAxisCellCount: _random.nextInt(2) + 1,
// //         child: Container(
// //           color: Colors.primaries[
// //               _random.nextInt(Colors.primaries.length)],
// //         ),
// //       );
// //     }),
// //   ),
// // ),
//
// // containerBorder(
// //   child: GridView.builder(
// //     shrinkWrap: true,
// //     physics: const NeverScrollableScrollPhysics(),
// //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //       crossAxisCount: Responsive.isDesktop(context)
// //           ? 2
// //           : Responsive.isTablet(context)
// //               ? 2
// //               : Responsive.isMobile(context)
// //                   ? 1
// //                   : 1,
// //     ),
// //     itemCount: portafolioItems.length,
// //     itemBuilder: (context, index) {
// //       final items = portafolioItems[index];
// //       return Container(
// //         decoration: BoxDecoration(
// //             color: items.color,
// //             border: Border.all(color: Colors.black, width: 0.2)),
// //         child: Stack(
// //           children: [
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(height: 10.0),
// //                 Padding(
// //                   padding: EdgeInsets.symmetric(
// //                       horizontal: horizontal),
// //                   child: Text(
// //                     items.name.toUpperCase(),
// //                     style: StyleText.textStyleOriginal(
// //                         fontSize: 5.0 * textScaleFactor),
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: EdgeInsets.symmetric(
// //                       horizontal: horizontal),
// //                   child: Text(
// //                     items.description.toUpperCase(),
// //                     style: StyleText.textStyleOriginal(
// //                         fontSize: 6.0 * textScaleFactor,
// //                         fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //                 // Expanded(
// //                 //   child: containerBorder(
// //                 //       width: size.width,
// //                 //       child: Image.asset(items.logo)),
// //                 // ),
// //               ],
// //             ),
// //             // Positioned(
// //             //   right: 0,
// //             //   child: containerBorder(
// //             //     width: 20,
// //             //     height: size.height,
// //             //     color: UtilsColor.colorOriginalPorfolioB,
// //             //     child: Column(
// //             //       crossAxisAlignment: CrossAxisAlignment.end,
// //             //       children: [
// //             //         const SizedBox(height: 5.0),
// //             //         for (var letter in items.tecnology[0]
// //             //             .split(',')
// //             //             .join()
// //             //             .split(''))
// //             //           Center(
// //             //             child: Text(
// //             //               letter.toUpperCase(),
// //             //               style: StyleText.textStyleOriginal(
// //             //                 fontSize: 11.0,
// //             //                 fontWeight: FontWeight.bold,
// //             //                 color:
// //             //                     UtilsColor.colorOriginalPorfolio,
// //             //               ),
// //             //             ),
// //             //           ),
// //             //       ],
// //             //     ),
// //             //   ),
// //             // ),
// //             Positioned(
// //               bottom: 0,
// //               child: InkWell(
// //                 onTap: () => launchUrl(items.url),
// //                 child: containerBorder(
// //                   color: UtilsColor.colorOriginalPorfolio,
// //                   top: true,
// //                   right: true,
// //                   width: 210.0,
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(5.0),
// //                     child: Row(
// //                       children: [
// //                         Text('visualizar proyecto'.toUpperCase()),
// //                         const SizedBox(width: 5.0),
// //                         const Icon(
// //                             Icons.arrow_circle_right_outlined)
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       );
// //     },
// //   ),
// // ),
