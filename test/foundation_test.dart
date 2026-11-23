import 'package:celestial/app/localization/locale_controller.dart';
import 'package:celestial/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'device language list resolves in preference order with US fallback',
    () {
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
    },
  );
  test('manual locale persists and use-device clears it', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final first = ProviderContainer(
      overrides: [preferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(first.dispose);
    await first.read(localeProvider.notifier).select('es');
    final reopened = ProviderContainer(
      overrides: [preferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(reopened.dispose);
    expect(reopened.read(localeProvider), const Locale('es', 'US'));
    await reopened.read(localeProvider.notifier).select(null);
    expect(prefs.getString(LocaleController.preferenceKey), isNull);
  });
  testWidgets('five shell tabs navigate and retain home scroll', (
    tester,
  ) async {
    final container = await launchPrototype(tester);
    expect(find.byType(NavigationDestination), findsNWidgets(5));
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -400),
    );
    await settlePrototype(tester);
    final position = tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position
        .pixels;
    for (final label in ['Astrology', 'Love', 'Wellness', 'Profile', 'Home']) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await settlePrototype(tester);
      expect(tester.takeException(), isNull, reason: label);
    }
    expect(
      tester
          .state<ScrollableState>(find.byType(Scrollable).first)
          .position
          .pixels,
      position,
    );
    container.read(routerProvider).push('/settings');
    await settlePrototype(tester);
    container.read(routerProvider).pop();
    await settlePrototype(tester);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
  testWidgets(
    'device Spanish, instant English override and restored device language',
    (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('es', 'MX')];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      await launchPrototype(tester, route: '/language', language: null);
      expect(find.text('Idioma'), findsOneWidget);
      await tapVisible(tester, find.text('English'));
      expect(find.text('Language'), findsOneWidget);
      await tapVisible(tester, find.text('Use device language'));
      expect(find.text('Idioma'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
