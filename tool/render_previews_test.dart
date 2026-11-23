// Run explicitly: flutter test tool/render_previews_test.dart --update-goldens
import 'package:celestial/core/demo/prototype_controller.dart';
import 'package:celestial/core/models/prototype_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    for (final font in [
      ('Playfair Display', 'PlayfairDisplay.ttf'),
      ('Plus Jakarta Sans', 'PlusJakartaSans.ttf'),
    ]) {
      final loader = FontLoader(font.$1)
        ..addFont(rootBundle.load('assets/fonts/${font.$2}'));
      await loader.load();
    }
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    final symbols = FontLoader('Noto Symbols2')
      ..addFont(rootBundle.load('assets/fonts/NotoSansSymbols2-Regular.ttf'));
    await symbols.load();
    final zodiac = FontLoader('Noto Symbols')
      ..addFont(rootBundle.load('assets/fonts/NotoSansSymbols.ttf'));
    await zodiac.load();
  });
  const screens = [
    ('01-welcome', '/welcome'),
    ('02-birth-details', '/birth-details'),
    ('03-interests', '/interests'),
    ('04-home', '/home'),
    ('05-astrology', '/astrology'),
    ('06-horoscope', '/horoscope'),
    ('07-love', '/love'),
    ('08-wellness', '/wellness'),
    ('09-profile', '/profile'),
    ('10-calendar', '/calendar'),
    ('11-subscription', '/premium'),
    ('12-natal-chart', '/birth-chart'),
  ];
  for (final screen in screens) {
    testWidgets('render ${screen.$1}', (tester) async {
      final container = await launchPrototype(tester, route: screen.$2);
      container
          .read(prototypeProvider.notifier)
          .setProfile(
            UserProfile(
              name: 'Elena Vance',
              birthDate: DateTime(1994, 10, 14),
              birthMinutes: 402,
              city: 'Seattle, WA',
            ),
          );
      await settlePrototype(tester);
      final context = tester.element(find.byKey(const Key('review-boundary')));
      await tester.runAsync(() async {
        for (final asset in [
          'assets/stitch/7__love_hub_1.jpg',
          'assets/stitch/7__love_hub_2.jpg',
          'assets/stitch/8__wellness_hub_1.jpg',
          'assets/stitch/9__profile_1.jpg',
          'assets/stitch/11__celestial_plus_subscription_1.jpg',
          'assets/stitch/12__natal_chart_deep_dive_1.jpg',
          'assets/stitch/12__natal_chart_deep_dive_2.jpg',
        ]) {
          await precacheImage(AssetImage(asset), context);
        }
      });
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byKey(const Key('review-boundary')),
        matchesGoldenFile('../docs/previews/${screen.$1}.png'),
      );
      if (![
        '01-welcome',
        '02-birth-details',
        '03-interests',
      ].contains(screen.$1)) {
        await tester.drag(
          find.byType(SingleChildScrollView).first,
          const Offset(0, -600),
        );
        await settlePrototype(tester);
        await expectLater(
          find.byKey(const Key('review-boundary')),
          matchesGoldenFile('../docs/previews/${screen.$1}-scroll.png'),
        );
      }
    });
  }
}
