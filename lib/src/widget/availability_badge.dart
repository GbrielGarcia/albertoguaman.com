import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Badge de disponibilidad laboral + rol buscado.
class AvailabilityBadge extends StatelessWidget {
  const AvailabilityBadge({
    super.key,
    this.compact = false,
    this.showCta = true,
  });

  final bool compact;
  final bool showCta;

  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context)!;
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? SizeUtils.m : SizeUtils.l),
      decoration: BoxDecoration(
        color: UtilsColor.colorBlue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: UtilsColor.colorBlue.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF3DDC97),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: SizeUtils.s),
              Expanded(
                child: Text(
                  al.availabilityOpen,
                  style: StyleText.textPortfolio(
                    fontSize: bodySize * 0.95,
                    fontWeight: FontWeight.w700,
                    color: UtilsColor.colorSecondaryWhite,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeUtils.s),
          Text(
            al.availabilityRole,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.9,
              color: UtilsColor.colorMuted,
              height: 1.35,
            ),
          ),
          if (showCta) ...[
            SizedBox(height: SizeUtils.m),
            TextButton(
              onPressed: () => context.go('/contacto'),
              style: TextButton.styleFrom(
                foregroundColor: UtilsColor.colorBlue,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                al.contacMe,
                style: StyleText.textPortfolio(
                  fontSize: bodySize * 0.92,
                  fontWeight: FontWeight.w700,
                  color: UtilsColor.colorBlue,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
