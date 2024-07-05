import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale get locale => _locale ?? const Locale('es');

  void changeLocale(Locale newLocale) {
    if(newLocale == const Locale('en')) {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('es');
    }
    notifyListeners();
  }
}
  //   if (newLocale == const Locale('en') ||
  //       newLocale == const Locale('pt') ||
  //       newLocale.languageCode != 'es') {
  //     _locale = newLocale;
  //   } else {
  //     _locale = const Locale('es');
  //   }
  //   notifyListeners();
  // }}
