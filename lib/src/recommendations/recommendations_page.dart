import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';

/// Página de recomendaciones — reseñas certificadas por Google.
class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    final isNarrow = context.isMobile || context.isMobileLarge;
    final columns = isNarrow ? 1 : (context.screenWidth > 900 ? 3 : 2);

    return SitePageFrame(
      title: al.testimonials,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GoogleCertifiedBanner(al: al, bodySize: bodySize),
          SizedBox(height: SizeUtils.xl),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = SizeUtils.l;
              final width = constraints.maxWidth;
              final cardW = columns == 1
                  ? width
                  : (width - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final t in infoTestimonials)
                    SizedBox(
                      width: cardW,
                      child: _QuoteBlock(t: t, bodySize: bodySize),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GoogleCertifiedBanner extends StatelessWidget {
  const _GoogleCertifiedBanner({required this.al, required this.bodySize});

  final AppLocalizations al;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeUtils.l,
        vertical: SizeUtils.m,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: UtilsColor.hairline),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified,
            size: 22,
            color: UtilsColor.colorBlue,
          ),
          SizedBox(width: SizeUtils.s),
          Expanded(
            child: Text(
              al.testimonialsGoogleCertified,
              style: StyleText.textPortfolio(
                fontSize: bodySize * 0.98,
                fontWeight: FontWeight.w600,
                color: UtilsColor.colorSecondaryWhite,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteBlock extends StatelessWidget {
  const _QuoteBlock({required this.t, required this.bodySize});

  final Testimonial t;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        SizeUtils.l,
        SizeUtils.l,
        SizeUtils.l,
        SizeUtils.m,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: UtilsColor.colorBlue, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.quote,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 1.02,
              color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.94),
              height: 1.5,
            ),
          ),
          SizedBox(height: SizeUtils.l),
          Text(
            t.name,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.95,
              fontWeight: FontWeight.w700,
              color: UtilsColor.colorSecondaryWhite,
            ),
          ),
          if (t.date != null && t.date!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: SizeUtils.s / 2),
              child: Text(
                t.date!,
                style: StyleText.textPortfolio(
                  fontSize: bodySize * 0.78,
                  color: UtilsColor.colorMuted,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
