import 'package:celestial/app/router/app_router.dart';
import 'package:celestial/core/demo/catalog_repository.dart';
import 'package:celestial/core/models/prototype_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:celestial/app/localization/locale_controller.dart';
import 'package:celestial/app/app.dart';
import 'test_app.dart';

class FailingCatalog implements CatalogRepository {
  @override
  Future<PrototypeCatalog> load(String locale) =>
      Future.error(StateError('fixture failure'));
  @override
  List<CosmicEvent> events(dynamic l, DateTime month) => [];
}

void main() {
  for (final language in ['en', 'es']) {
    testWidgets(
      'all concrete routes render and scroll at 320px / 200% ($language)',
      (tester) async {
        final container = await launchPrototype(
          tester,
          language: language,
          width: 320,
          height: 740,
          scale: 2,
        );
        for (final route in prototypeRouteSamples.where(
          (r) => r != '/splash',
        )) {
          container.read(routerProvider).go(route);
          await settlePrototype(tester);
          expect(
            tester.takeException(),
            isNull,
            reason: '$language $route initial viewport',
          );
          final scroll = find.byType(SingleChildScrollView).first;
          for (var i = 0; i < 3; i++) {
            await tester.drag(scroll, const Offset(0, -600));
            await settlePrototype(tester);
            expect(
              tester.takeException(),
              isNull,
              reason: '$language $route scroll $i',
            );
          }
        }
      },
    );
  }
  testWidgets(
    'catalog error has retry and recovers after repository replacement',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          preferencesProvider.overrideWithValue(prefs),
          initialLocationProvider.overrideWithValue('/meditations'),
          catalogRepositoryProvider.overrideWithValue(FailingCatalog()),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const CelestialApp(),
        ),
      );
      await settlePrototype(tester);
      expect(find.text('Try again'), findsOneWidget);
      container.updateOverrides([
        preferencesProvider.overrideWithValue(prefs),
        initialLocationProvider.overrideWithValue('/meditations'),
        catalogRepositoryProvider.overrideWithValue(
          const MockCatalogRepository(),
        ),
      ]);
      container.invalidate(catalogProvider('en_US'));
      await settlePrototype(tester);
      expect(find.text('Evening Moonrise Meditation'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
