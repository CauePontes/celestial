import 'package:celestial/app/app.dart';
import 'package:celestial/app/localization/locale_controller.dart';
import 'package:celestial/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> launchPrototype(
  WidgetTester tester, {
  String route = '/home',
  String? language = 'en',
  double width = 390,
  double height = 884,
  double scale = 1,
}) async {
  SharedPreferences.setMockInitialValues({
    LocaleController.preferenceKey: ?language,
  });
  final preferences = await SharedPreferences.getInstance();
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  late ProviderContainer container;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        preferencesProvider.overrideWithValue(preferences),
        initialLocationProvider.overrideWithValue(route),
      ],
      child: Builder(
        builder: (context) {
          container = ProviderScope.containerOf(context);
          return const RepaintBoundary(
            key: Key('review-boundary'),
            child: CelestialApp(),
          );
        },
      ),
    ),
  );
  await settlePrototype(tester);
  return container;
}

Future<void> settlePrototype(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pumpAndSettle();
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder.first);
  await tester.pumpAndSettle();
  if (finder.hitTestable().evaluate().isEmpty) {
    final scroll = find.byType(SingleChildScrollView).first;
    await tester.drag(scroll, const Offset(0, -350));
    await tester.pumpAndSettle();
  }
  await tester.tap(finder.hitTestable().first);
  await settlePrototype(tester);
}
