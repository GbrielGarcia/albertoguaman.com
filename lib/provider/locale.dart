import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider() {
    unawaited(_loadPersisted());
  }

  static const _prefsKey = 'app_locale';

  Locale? _locale;

  Locale get locale => _locale ?? const Locale('es');

  Future<void> _loadPersisted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefsKey);
      if (code == null) return;
      final next = Locale(code);
      if (next.languageCode == locale.languageCode) return;
      _locale = next.languageCode == 'en'
          ? const Locale('en')
          : const Locale('es');
      notifyListeners();
    } catch (_) {
      // Sin almacenamiento: se mantiene el idioma por defecto.
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    final next = newLocale.languageCode == 'en'
        ? const Locale('en')
        : const Locale('es');
    if (_locale?.languageCode == next.languageCode) return;
    _locale = next;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, next.languageCode);
    } catch (_) {
      // El idioma en memoria sigue aplicando en la sesión.
    }
  }

  Future<void> toggleLocale() async {
    await changeLocale(
      locale.languageCode == 'es' ? const Locale('en') : const Locale('es'),
    );
  }
}
