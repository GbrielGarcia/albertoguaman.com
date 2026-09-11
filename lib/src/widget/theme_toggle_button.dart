import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/provider/provider.dart';
import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModeProvider>();
    final al = AppLocalizations.of(context);

    return IconButton(
      tooltip: al?.themeToggle ?? 'Tema',
      onPressed: () => theme.toggle(),
      icon: Icon(
        theme.isLight ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: UtilsColor.colorBlue,
      ),
    );
  }
}
