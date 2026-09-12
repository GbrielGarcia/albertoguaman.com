import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/provider/provider.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Alterna ES ↔ EN (persistido en SharedPreferences vía [LocaleProvider]).
class LocaleToggleButton extends StatelessWidget {
  const LocaleToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>();
    final al = AppLocalizations.of(context);
    final code = locale.locale.languageCode.toUpperCase();

    return TextButton(
      onPressed: () => locale.toggleLocale(),
      style: TextButton.styleFrom(
        foregroundColor: UtilsColor.colorBlue,
        minimumSize: const Size(44, 40),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(
        code,
        semanticsLabel: al?.languageToggle ?? 'Idioma',
        style: StyleText.textPortfolio(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: UtilsColor.colorBlue,
        ),
      ),
    );
  }
}
