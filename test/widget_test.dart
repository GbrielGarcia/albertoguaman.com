import 'package:albertoguaman/l10n/app_localizations.dart';
import 'package:albertoguaman/provider/locale.dart';
import 'package:albertoguaman/provider/theme_mode.dart';
import 'package:albertoguaman/router/routers.dart';
import 'package:albertoguaman/src/model/blog_post.dart';
import 'package:albertoguaman/src/utils/seo.dart';
import 'package:albertoguaman/src/widget/bubble_background_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('isValidAppPath accepts known routes and blog slugs', () {
    expect(isValidAppPath('/'), isTrue);
    expect(isValidAppPath('/blog'), isTrue);
    expect(isValidAppPath('/casos'), isTrue);
    expect(isValidAppPath('/recomendaciones'), isTrue);
    expect(isValidAppPath('/cv'), isTrue);
    expect(isValidAppPath('/contacto'), isTrue);
    expect(isValidAppPath('/no-existe'), isFalse);
    expect(isValidAppPath('/blog/no-existe-slug'), isFalse);

    final first = infoBlogPosts.first;
    expect(isValidAppPath('/blog/${first.slug}'), isTrue);
  });

  test('pageSeoData covers primary SPA routes', () {
    for (final path in [
      '/',
      '/bio',
      '/blog',
      '/contacto',
      '/cv',
      '/casos',
      '/recomendaciones',
      '/galeria',
    ]) {
      expect(pageSeoData.containsKey(path), isTrue, reason: path);
      expect(pageSeoData[path]!.$1.isNotEmpty, isTrue);
      expect(pageSeoData[path]!.$2.isNotEmpty, isTrue);
    }
  });

  testWidgets('Portfolio home loads with brand name', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          ChangeNotifierProvider(create: (_) => BubbleBackgroundProvider()),
          ChangeNotifierProvider(create: (_) => ThemeModeProvider()),
        ],
        child: MaterialApp.router(
          locale: const Locale('es'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: goRouter,
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.textContaining('Alberto Guaman'), findsWidgets);
  });
}
