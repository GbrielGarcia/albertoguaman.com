import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/home.dart';
import '../provider/provider.dart';
import '../utils/utils.dart';

class PopupMenuButtonWidget extends StatefulWidget {
  const PopupMenuButtonWidget({super.key});

  @override
  State<PopupMenuButtonWidget> createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  String _selecLanguegeCode = 'en';
  @override
  Widget build(BuildContext context) {
    final al = AppLocalizations.of(context);

    return PopupMenuButton<String>(
      initialValue: '',
      icon: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AssetsUtil.imgBackgroundMinecraft,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Idioma'.toUpperCase(),
            style: StyleText.textStyleClass(),
          ),
        ),
      ),
      tooltip: al!.selectLanguage,
      onSelected: (String value) {
        setState(() {
          _selecLanguegeCode = value;
        });
        _onLanguageSelected(context);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem(child: Text('English'), value: 'en'),
        PopupMenuItem(child: Text('Español'), value: 'es'),
        PopupMenuItem(child: Text('Postugúes'), value: 'pt')
      ],
    );
  }


  void _onLanguageSelected(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    Locale newLocale = _getLocale(_selecLanguegeCode);
    localeProvider.changeLocale(newLocale);
  }

  Locale _getLocale(String languajeCode) {
    switch (languajeCode) {
      case 'en':
        return const Locale('en');
      case 'es':
        return const Locale('es');
      case 'pt':
        return const Locale('pt');
      default:
        return const Locale('en');
    }
  }
}
