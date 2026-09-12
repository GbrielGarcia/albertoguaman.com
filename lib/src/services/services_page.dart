import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final isNarrow = context.isMobile || context.isMobileLarge;
    final offers = infoServiceOffers;

    return SitePageFrame(
      title: 'Servicios',
      subtitle:
          'Paquetes claros para soporte, Flutter, web y e-commerce. Copy orientado a resultados, adaptado de mi trabajo con Tinguar.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = SizeUtils.l;
              final columns = isNarrow ? 1 : 2;
              final tileW =
                  (constraints.maxWidth - (gap * (columns - 1))) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final offer in offers)
                    SizedBox(
                      width: tileW,
                      child: _ServiceCard(offer: offer, bodySize: bodySize),
                    ),
                ],
              );
            },
          ),
          SizedBox(height: SizeUtils.xl),
          containerBottom(
            () => context.go('/contacto'),
            '/contacto',
            'Hablar de un proyecto',
            width: double.infinity,
            variant: PortfolioButtonVariant.solid,
            padding: 0,
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.offer, required this.bodySize});

  final ServiceOffer offer;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeUtils.l),
      decoration: BoxDecoration(
        color: UtilsColor.colorSurface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: UtilsColor.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.title.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.8,
              fontWeight: FontWeight.w800,
              color: UtilsColor.colorBlue,
            ).copyWith(letterSpacing: 1.1),
          ),
          SizedBox(height: SizeUtils.s),
          Text(
            offer.outcome,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 1.15,
              fontWeight: FontWeight.w800,
              color: UtilsColor.colorSecondaryWhite,
              height: 1.2,
            ),
          ),
          SizedBox(height: SizeUtils.s),
          Text(
            offer.pitch,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.95,
              color: UtilsColor.colorMuted,
              height: 1.45,
            ),
          ),
          SizedBox(height: SizeUtils.m),
          Wrap(
            spacing: SizeUtils.s,
            runSpacing: SizeUtils.s / 2,
            children: [
              for (final h in offer.highlights)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.s,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: UtilsColor.colorYellowSoft,
                    borderRadius: BorderRadius.circular(SizeUtils.m),
                  ),
                  child: Text(
                    h,
                    style: StyleText.textPortfolio(
                      fontSize: bodySize * 0.8,
                      fontWeight: FontWeight.w600,
                      color: UtilsColor.colorYellowInk,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: SizeUtils.m),
          Text(
            offer.description,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.92,
              color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.9),
              height: 1.45,
            ),
          ),
          SizedBox(height: SizeUtils.m),
          Text(
            'INCLUYE',
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.75,
              fontWeight: FontWeight.w700,
              color: UtilsColor.colorMuted,
            ),
          ),
          SizedBox(height: SizeUtils.s / 2),
          for (final line in offer.includes)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '· $line',
                style: StyleText.textPortfolio(
                  fontSize: bodySize * 0.9,
                  color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.88),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
