// Explicit asset tool: flutter test tool/generate_icons_test.dart
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:celestial/app/theme/app_colors.dart';
import 'package:celestial/core/widgets/orbital_crest.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('generate original orbital launcher art', (tester) async {
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
    tester.view.physicalSize = const Size(512, 512);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const RepaintBoundary(
        key: Key('icon'),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: ColoredBox(
            color: AppColors.background,
            child: Center(child: OrbitalCrest(size: 440)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final targets = <String, int>{
      'web/favicon.png': 32,
      'web/icons/Icon-192.png': 192,
      'web/icons/Icon-512.png': 512,
      'web/icons/Icon-maskable-192.png': 192,
      'web/icons/Icon-maskable-512.png': 512,
      'android/app/src/main/res/mipmap-mdpi/ic_launcher.png': 48,
      'android/app/src/main/res/mipmap-hdpi/ic_launcher.png': 72,
      'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png': 96,
      'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png': 144,
      'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png': 192,
    };
    for (final file in Directory(
      'ios/Runner/Assets.xcassets/AppIcon.appiconset',
    ).listSync().whereType<File>()) {
      final match = RegExp(
        r'Icon-App-([\d.]+)x[\d.]+@(\d)x\.png',
      ).firstMatch(file.path);
      if (match != null) {
        targets[file.path] = (double.parse(match[1]!) * int.parse(match[2]!))
            .round();
      }
    }
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(const Key('icon')),
    );
    await tester.runAsync(() async {
      for (final entry in targets.entries) {
        final image = await boundary.toImage(pixelRatio: entry.value / 512);
        final png = await image.toByteData(format: ui.ImageByteFormat.png);
        await File(entry.key).writeAsBytes(png!.buffer.asUint8List());
        image.dispose();
      }
    });
    expect(tester.takeException(), isNull);
  });
}
