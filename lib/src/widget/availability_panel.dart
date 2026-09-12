import 'package:albertoguaman/src/model/model.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';

/// Bloque de disponibilidad / ubicación / contrato / stack preferido.
class AvailabilityPanel extends StatelessWidget {
  const AvailabilityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final bodySize = TextStyleSize.textDescriptionSize(context.screenWidth);
    const info = siteAvailability;

    return Container(
      width: double.infinity,
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
            info.status.toUpperCase(),
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.78,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF22C55E),
            ).copyWith(letterSpacing: 1.0),
          ),
          SizedBox(height: SizeUtils.m),
          _row('Ubicación', info.location, bodySize),
          _row('Modalidad', info.workMode, bodySize),
          _row('Contrato', info.contract, bodySize),
          _row('Stack preferido', info.preferredStack, bodySize),
          SizedBox(height: SizeUtils.s),
          Text(
            info.note,
            style: StyleText.textPortfolio(
              fontSize: bodySize * 0.92,
              color: UtilsColor.colorMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, double bodySize) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeUtils.s / 2),
      child: RichText(
        text: TextSpan(
          style: StyleText.textPortfolio(
            fontSize: bodySize * 0.95,
            color: UtilsColor.colorSecondaryWhite,
            height: 1.35,
          ),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: UtilsColor.colorMuted,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
