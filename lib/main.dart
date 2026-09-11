import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '/provider/provider.dart';
import 'package:albertoguaman/src/widget/bubble_background_effect.dart';
import 'package:albertoguaman/l10n/app_localizations.dart';

import 'router/routers.dart';

Future<void> _initFirebase() async {
  final supported = kIsWeb ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.windows;
  if (!supported) return;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  await _initFirebase();
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => BubbleBackgroundProvider()),
        ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeModeProvider>(context);

    return MaterialApp.router(
      locale: localProvider.locale,
      debugShowCheckedModeBanner: false,
      title: 'Alberto Guaman | Portafolio',
      routerConfig: goRouter,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      themeMode: themeProvider.mode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFECE9E2),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF707EFF),
          secondary: Color(0xFFFAD85D),
          surface: Color(0xFFFFFFFF),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF151515),
          onSurface: Color(0xFF151515),
        ),
        fontFamily: 'Alegreya',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF151515),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF707EFF),
          secondary: Color(0xFFFAD85D),
          surface: Color(0xFF1C1C1C),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF151515),
          onSurface: Color(0xFFFFFFFF),
        ),
        fontFamily: 'Alegreya',
      ),
    );
  }
}
