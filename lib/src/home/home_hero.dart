import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:albertoguaman/src/widget/icon_data_row.dart';
import 'package:albertoguaman/src/widget/open_to_work_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hero del inicio: copy + CTAs + avatar.
class HomeHero extends StatelessWidget {
  const HomeHero({
    super.key,
    required this.al,
    required this.titleSize,
    required this.bodySize,
    required this.isNarrow,
    required this.onDownloadCv,
  });

  final AppLocalizations al;
  final double titleSize;
  final double bodySize;
  final bool isNarrow;
  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) {
    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          al.administratorIt,
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.95,
            fontWeight: FontWeight.w600,
            color: UtilsColor.colorBlue,
          ).copyWith(letterSpacing: 0.4),
        ),
        SizedBox(height: SizeUtils.m),
        Text(
          'Alberto Guaman',
          style: StyleText.textPortfolio(
            fontSize: isNarrow ? titleSize * 1.15 : titleSize * 1.35,
            fontWeight: FontWeight.w800,
            color: UtilsColor.colorSecondaryWhite,
            height: 1.05,
          ),
        ),
        SizedBox(height: SizeUtils.l),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            al.homeHeroLead,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 1.05,
              color: UtilsColor.colorMuted,
              height: 1.55,
            ),
          ),
        ),
        SizedBox(height: SizeUtils.xl),
        Wrap(
          spacing: SizeUtils.s,
          runSpacing: SizeUtils.s,
          children: [
            HomeHeroCta(
              label: al.contact,
              onTap: () => context.go('/contacto'),
              solid: true,
            ),
            HomeHeroCta(
              label: al.navCaseStudies,
              onTap: () => context.go('/casos'),
            ),
            HomeHeroCta(
              label: al.downloadCv,
              onTap: onDownloadCv,
            ),
          ],
        ),
        SizedBox(height: SizeUtils.l),
        iconDataRow(),
      ],
    );

    final avatar = OpenToWorkAvatar(size: isNarrow ? 168 : 230);

    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          avatar,
          SizedBox(height: SizeUtils.xl),
          copy,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: copy),
        SizedBox(width: SizeUtils.xl),
        avatar,
      ],
    );
  }
}

class HomeHeroCta extends StatelessWidget {
  const HomeHeroCta({
    super.key,
    required this.label,
    required this.onTap,
    this.solid = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool solid;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            color: solid ? UtilsColor.colorBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: solid ? UtilsColor.colorBlue : UtilsColor.hairline,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.l,
              vertical: SizeUtils.s1 * 0.75,
            ),
            child: Text(
              label,
              style: StyleText.textPortfolio(
                fontSize:
                    TextStyleSize.textDescriptionSize(context.screenWidth) *
                        0.95,
                fontWeight: FontWeight.w700,
                color: solid
                    ? (UtilsColor.useLight
                        ? Colors.white
                        : UtilsColor.colorSecondaryWhite)
                    : UtilsColor.colorSecondaryWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
