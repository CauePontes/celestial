import 'package:celestial/app/router/app_router.dart';
import 'package:celestial/app/localization/locale_controller.dart';
import 'package:celestial/app/theme/appearance_controller.dart';
import 'package:celestial/core/demo/catalog_repository.dart';
import 'package:celestial/core/demo/prototype_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test_app.dart';

void main() {
  test(
    'localized catalog meets fixture counts and immutable data contract',
    () async {
      const repo = MockCatalogRepository();
      final en = await repo.load('en_US'), es = await repo.load('es_US');
      expect(en.signs.length, 12);
      expect(en.meditations.length, 6);
      expect(en.posts.length, 8);
      expect(en.meditations.first.title, isNot(es.meditations.first.title));
      expect(en.posts.first.body, isNot(es.posts.first.body));
      expect(() => en.signs.clear(), throwsUnsupportedError);
    },
  );
  test('appearance persists across provider containers', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final first = ProviderContainer(
      overrides: [preferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(first.dispose);
    await first.read(appearanceProvider.notifier).select(true);
    final reopened = ProviderContainer(
      overrides: [preferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(reopened.dispose);
    expect(reopened.read(appearanceProvider), isTrue);
  });
  testWidgets(
    'meditation category and duration filter produce correct empty state',
    (tester) async {
      await launchPrototype(tester, route: '/meditations');
      await tapVisible(tester, find.text('Sleep'));
      expect(find.text('A Softer Landing'), findsOneWidget);
      expect(find.text('First Light Stillness'), findsNothing);
      await tapVisible(tester, find.text('Up to 10 min'));
      expect(find.text('No results found'), findsOneWidget);
      await tapVisible(tester, find.text('All durations'));
      expect(find.text('Under a Quiet Sky'), findsOneWidget);
    },
  );
  testWidgets('calendar category filters, saving and day selection work', (
    tester,
  ) async {
    final container = await launchPrototype(tester, route: '/calendar');
    await tapVisible(tester, find.text('Moon Phases'));
    expect(find.text('New Moon in Scorpio'), findsOneWidget);
    expect(find.text('Mars enters Leo'), findsNothing);
    await tapVisible(tester, find.text('Save').first);
    expect(container.read(prototypeProvider).saved.length, 1);
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, 1500),
    );
    await settlePrototype(tester);
    await tester.tap(find.byTooltip('Cosmic Calendar'));
    await settlePrototype(tester);
    await tapVisible(tester, find.widgetWithText(TextButton, '2'));
    expect(find.text('A quiet day in this preview'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('expanded calendar remains usable at Spanish 200% scaling', (
    tester,
  ) async {
    await launchPrototype(
      tester,
      route: '/calendar',
      language: 'es',
      width: 320,
      height: 740,
      scale: 2,
    );
    await tester.tap(find.byTooltip('Calendario cósmico'));
    await settlePrototype(tester);
    expect(tester.takeException(), isNull);
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -700),
    );
    await settlePrototype(tester);
    expect(tester.takeException(), isNull);
  });
  testWidgets('chart filters expose planets houses and aspects', (
    tester,
  ) async {
    await launchPrototype(tester, route: '/birth-chart');
    await tapVisible(tester, find.text('Planets'));
    expect(find.text('Pluto'), findsOneWidget);
    await tapVisible(tester, find.text('Houses').first);
    expect(find.text('Houses 12'), findsOneWidget);
    await tapVisible(tester, find.text('Aspects'));
    expect(find.text('Venus Trine Neptune'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('discover search and saved filter and player unavailable state', (
    tester,
  ) async {
    final container = await launchPrototype(tester, route: '/discover');
    await tester.enterText(find.byType(TextField), 'zzzz');
    await settlePrototype(tester);
    expect(find.text('No results found'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'breathing');
    await settlePrototype(tester);
    expect(find.text('Breathing Exercises'), findsOneWidget);
    container.read(routerProvider).go('/meditation-player/moonrise');
    await settlePrototype(tester);
    expect(find.text('Audio preview unavailable'), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(
            find.widgetWithIcon(IconButton, Icons.play_circle_outline),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('favorites restore the saved period sign and date',(tester)async{
    final container=await launchPrototype(tester,route:'/favorites');
    container.read(prototypeProvider.notifier).toggleSaved('horoscope-3-1-2026-11-22');
    await settlePrototype(tester);
    await tapVisible(tester,find.text('Horoscope'));
    expect(find.text('Harmonies built on patient timing'),findsOneWidget);
    expect(find.text('November 22, 2026'),findsOneWidget);
    expect(container.read(routerProvider).routeInformationProvider.value.uri.queryParameters['sign'],'3');
  });
}
