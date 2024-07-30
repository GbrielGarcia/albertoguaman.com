import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html;
import '../utils/utils.dart';
import 'widgets.dart';

class DynamicContainersList extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  final int? style;

  const DynamicContainersList({
    Key? key,
    required this.dataList,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final al = AppLocalizations.of(context);

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width >= 1024
                ? 3
                : size.width >= 700
                    ? 2
                    : 1,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: size.width >= 1024
                ? 1.6
                : size.width >= 700
                    ? 1.3
                    : 1.3,
          ),
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            final data = dataList[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    html.window.open(
                      data['link'],
                      data['proyect'],
                    );
                  },
                  child: Container(
                    width: Responsive.isDesktop(context)
                        ? size.width * 0.3
                        : size.width * 0.9,
                    height: 240,
                    decoration: style == 1
                        ? BoxDecoration(
                            color: UtilsColor.colorOriginalPorfolioW,
                            border:
                                Border.all(color: data['color'], width: 2.0))
                        : BoxDecoration(
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
                        rowInfoContainer(al!.company, data['title'], style!),
                        rowInfoContainer(al!.country, data['country'], style!),
                        rowInfoContainer(al!.project, data['proyect'], style!),
                        rowInfoContainer(al!.employment, data['jobs'], style!),
                        rowInfoContainer(al!.skills, data['skill'], style!),
                        Expanded(child: Container()),
                        Container(
                          width: double.infinity,
                          color: style == 1
                              ? data['color']
                              : UtilsColor.colorMinecraftPorfolioC,
                          child: Text(
                            al!.seeProject.toUpperCase(),
                            style: style == 1
                                ? StyleText.textStyleOriginal(
                                    color: UtilsColor.colorOriginalPorfolioB)
                                : StyleText.textStyleClass(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                style == 1
                    ? Container()
                    : Container(
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
