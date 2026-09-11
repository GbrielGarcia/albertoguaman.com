import 'package:albertoguaman/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider extends ChangeNotifier {
  static const _key = 'theme_mode_light';
  bool _light = false;

  bool get isLight => _light;
  ThemeMode get mode => _light ? ThemeMode.light : ThemeMode.dark;

  ThemeModeProvider() {
    UtilsColor.useLight = false;
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _light = prefs.getBool(_key) ?? false;
    UtilsColor.useLight = _light;
    notifyListeners();
  }

  Future<void> toggle() async {
    _light = !_light;
    UtilsColor.useLight = _light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _light);
  }
}
