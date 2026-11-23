import 'package:celestial/app/app.dart';
import 'package:celestial/app/localization/locale_controller.dart';
import 'package:celestial/core/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('device language list resolves by preference with US fallback', () {
    const supported = [Locale('en', 'US'), Locale('es', 'US')];
    expect(
      resolveDeviceLocales([const Locale('es', 'MX')], supported),
      const Locale('es', 'US'),
    );
    expect(
      resolveDeviceLocales([
        const Locale('pt', 'BR'),
        const Locale('es', 'ES'),
      ], supported),
      const Locale('es', 'US'),
    );
    expect(
      resolveDeviceLocales([
        const Locale('en', 'GB'),
        const Locale('es'),
      ], supported),
      const Locale('en', 'US'),
    );
    expect(
      resolveDeviceLocales([const Locale('fr')], supported),
      const Locale('en', 'US'),
    );
    expect(resolveDeviceLocales(null, supported), const Locale('en', 'US'));
  });

  test(
    'manual locale persists across containers and device reset clears it',
    () async {
      SharedPreferences.setMockInitialValues({});
      final preferences = await SharedPreferences.getInstance();
      final first = ProviderContainer(
        overrides: [preferencesProvider.overrideWithValue(preferences)],
      );
      addTearDown(first.dispose);
      expect(first.read(localeProvider), isNull);
      await first.read(localeProvider.notifier).select('es');
      final reopened = ProviderContainer(
        overrides: [preferencesProvider.overrideWithValue(preferences)],
      );
      addTearDown(reopened.dispose);
      expect(reopened.read(localeProvider), const Locale('es', 'US'));
      await reopened.read(localeProvider.notifier).select(null);
      expect(preferences.getString(LocaleController.preferenceKey), isNull);
      expect(reopened.read(localeProvider), isNull);
    },
  );

  Future<void> launch(
    WidgetTester tester, {
    String? language,
    double textScale = 1,
  }) async {
    SharedPreferences.setMockInitialValues({
      LocaleController.preferenceKey: ?language,
    });
    final preferences = await SharedPreferences.getInstance();
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [preferencesProvider.overrideWithValue(preferences)],
        child: const CelestialApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    'all five tabs navigate, home scroll is preserved, preview closes',
    (tester) async {
      await launch(tester);
      expect(find.byType(NavigationDestination), findsNWidgets(5));
      expect(find.text('Your cosmic\noutlook'), findsOneWidget);
      for (final label in [
        'Astrology',
        'Love',
        'Wellness',
        'Profile',
        'Home',
      ]) {
        await tester.tap(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(label),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      await tester.tap(find.byTooltip('Notifications'));
      await tester.pumpAndSettle();
      expect(find.textContaining('caught up'), findsOneWidget);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Explore more'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      final offset = tester
          .state<ScrollableState>(find.byType(Scrollable).first)
          .position
          .pixels;
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Love'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Home'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        tester
            .state<ScrollableState>(find.byType(Scrollable).first)
            .position
            .pixels,
        offset,
      );
    },
  );

  testWidgets(
    'device Spanish, instant manual English and restored device language',
    (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('es', 'MX')];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      await launch(tester);
      expect(find.text('Tu perspectiva\ncósmica'), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Perfil'),
        ),
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.byType(CustomScrollView).last,
        const Offset(0, -550),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();
      expect(find.text('Language'), findsOneWidget);
      await tester.tap(find.text('Use device language'));
      await tester.pumpAndSettle();
      expect(find.text('Idioma'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('small Spanish layout supports doubled text on every tab', (
    tester,
  ) async {
    await launch(tester, language: 'es', textScale: 2);
    expect(tester.takeException(), isNull);
    await tester.scrollUntilVisible(
      find.text('Explora más'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(tester.takeException(), isNull);
    for (final label in ['Astrología', 'Amor', 'Bienestar', 'Perfil']) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(DemoNotice), findsWidgets);
    }
  });
}
