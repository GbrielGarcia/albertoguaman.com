import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/widget.dart';
import 'package:flutter/material.dart';

/// Casos de estudio — estructura editorial numerada.
class CaseStudiesPage extends StatelessWidget {
  const CaseStudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return SitePageFrame(
      title: al.caseStudies,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < infoCaseStudies.length; i++) ...[
            if (i > 0) ...[
              SizedBox(height: SizeUtils.xl),
              Divider(color: UtilsColor.hairline, height: 1),
              SizedBox(height: SizeUtils.xl),
            ],
            _CaseStudyArticle(
              index: i + 1,
              study: infoCaseStudies[i],
              bodySize: bodySize,
              al: al,
            ),
          ],
        ],
      ),
    );
  }
}

class _CaseStudyArticle extends StatelessWidget {
  const _CaseStudyArticle({
    required this.index,
    required this.study,
    required this.bodySize,
    required this.al,
  });

  final int index;
  final CaseStudy study;
  final double bodySize;
  final AppLocalizations al;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${index.toString().padLeft(2, '0')}  ·  ${study.contextLabel}',
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.85,
            fontWeight: FontWeight.w700,
            color: UtilsColor.colorBlue,
          ).copyWith(letterSpacing: 1.2),
        ),
        SizedBox(height: SizeUtils.s),
        Text(
          study.title,
          style: StyleText.textPortfolio(
            fontSize: bodySize * 1.45,
            fontWeight: FontWeight.w800,
            color: UtilsColor.colorSecondaryWhite,
            height: 1.15,
          ),
        ),
        SizedBox(height: SizeUtils.s / 2),
        Text(
          study.role,
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.95,
            color: UtilsColor.colorMuted,
          ),
        ),
        SizedBox(height: SizeUtils.xl),
        _Block(label: al.caseStudyProblem, body: study.problem, bodySize: bodySize),
        SizedBox(height: SizeUtils.l),
        _Block(label: al.caseStudySolution, body: study.solution, bodySize: bodySize),
        SizedBox(height: SizeUtils.l),
        Text(
          al.caseStudyResults.toUpperCase(),
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.78,
            fontWeight: FontWeight.w700,
            color: UtilsColor.colorMuted,
          ),
        ),
        SizedBox(height: SizeUtils.s),
        for (final result in study.results)
          Padding(
            padding: EdgeInsets.only(bottom: SizeUtils.s / 2),
            child: Text(
              '—  $result',
              style: StyleText.textPortfolio(
                fontSize: bodySize,
                color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.92),
                height: 1.4,
              ),
            ),
          ),
        SizedBox(height: SizeUtils.l),
        Text(
          '${al.caseStudyStack}: ${study.stack}',
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.9,
            color: UtilsColor.colorBlue,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (study.linkUrl != null && study.linkUrl!.isNotEmpty) ...[
          SizedBox(height: SizeUtils.m),
          TextButton(
            onPressed: () => laucherURL(study.linkUrl!),
            style: TextButton.styleFrom(
              foregroundColor: UtilsColor.colorBlue,
              padding: EdgeInsets.zero,
            ),
            child: Text(
              study.linkLabel ?? al.contentReadMore,
              style: StyleText.textPortfolio(
                fontSize: bodySize,
                color: UtilsColor.colorBlue,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({
    required this.label,
    required this.body,
    required this.bodySize,
  });

  final String label;
  final String body;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.78,
            fontWeight: FontWeight.w700,
            color: UtilsColor.colorMuted,
          ),
        ),
        SizedBox(height: SizeUtils.s / 2),
        Text(
          body,
          style: StyleText.textPortfolio(
            fontSize: bodySize,
            color: UtilsColor.colorSecondaryWhite.withValues(alpha: 0.92),
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
