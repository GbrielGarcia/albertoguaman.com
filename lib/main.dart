import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import '/provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider(create: (context) => LocaleProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      locale: localProvider.locale,
      debugShowCheckedModeBanner: false,
      title: 'Alberto Guaman',
      routerDelegate: goRouter.routerDelegate,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
