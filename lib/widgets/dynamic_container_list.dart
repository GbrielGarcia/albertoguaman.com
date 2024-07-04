import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html;

import '../home/home.dart';
import '../utils/utils.dart';
import 'widgets.dart';

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