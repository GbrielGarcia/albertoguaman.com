import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return SitePageFrame(
      title: 'Cómo trabajo',
      subtitle: 'Proceso, tiempos, herramientas y comunicación.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < infoFaqHowIWork.length; i++) ...[
            if (i > 0) SizedBox(height: SizeUtils.l),
            _FaqTile(item: infoFaqHowIWork[i], bodySize: bodySize),
          ],
          SizedBox(height: SizeUtils.xl),
          containerBottom(
            () => context.go('/contacto'),
            '/contacto',
            'Escribirme',
            width: double.infinity,
            variant: PortfolioButtonVariant.solid,
            padding: 0,
          ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.item, required this.bodySize});

  final FaqItem item;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.only(bottom: SizeUtils.m),
        iconColor: UtilsColor.colorBlue,
        collapsedIconColor: UtilsColor.colorMuted,
        title: Text(
          item.question,
          style: StyleText.textPortfolio(
            fontSize: bodySize * 1.05,
            fontWeight: FontWeight.w700,
            color: UtilsColor.colorSecondaryWhite,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.answer,
              style: StyleText.textPortfolio(
                fontSize: bodySize,
                color: UtilsColor.colorMuted,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
