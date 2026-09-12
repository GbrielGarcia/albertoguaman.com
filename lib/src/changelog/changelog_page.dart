import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';

class ChangelogPage extends StatelessWidget {
  const ChangelogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return SitePageFrame(
      title: 'Cambios',
      subtitle: 'Notas de lo que voy tocando en este sitio.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < infoChangelog.length; i++) ...[
            if (i > 0) ...[
              SizedBox(height: SizeUtils.l),
              Divider(color: UtilsColor.hairline, height: 1),
              SizedBox(height: SizeUtils.l),
            ],
            Text(
              infoChangelog[i].date,
              style: StyleText.textPortfolio(
                fontSize: bodySize * 0.85,
                fontWeight: FontWeight.w700,
                color: UtilsColor.colorBlue,
              ),
            ),
            SizedBox(height: SizeUtils.s / 2),
            Text(
              infoChangelog[i].title,
              style: StyleText.textPortfolio(
                fontSize: bodySize * 1.15,
                fontWeight: FontWeight.w800,
                color: UtilsColor.colorSecondaryWhite,
              ),
            ),
            SizedBox(height: SizeUtils.s),
            for (final line in infoChangelog[i].items)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '· $line',
                  style: StyleText.textPortfolio(
                    fontSize: bodySize * 0.95,
                    color: UtilsColor.colorMuted,
                    height: 1.4,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
