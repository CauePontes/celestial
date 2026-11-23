import 'dart:convert';
import 'dart:io';
import 'package:celestial/app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every exported Stitch screen maps to a concrete implemented route', () {
    final inventory =
        jsonDecode(File('docs/design-inventory.json').readAsStringSync())
            as Map<String, dynamic>;
    final exported = Directory('design/screens')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('code.html'))
        .map((f) => f.parent.path.split(Platform.pathSeparator).last)
        .toSet();
    final screens = inventory['screens'] as List<dynamic>;
    expect(screens.map((s) => s['folder']).toSet(), exported);
    expect(screens.length, 12);
    for (final screen in screens) {
      expect(prototypeRouteSamples, contains(screen['route']));
      expect(File(screen['implementation'] as String).existsSync(), isTrue);
    }
  });
  test(
    'all referenced export images are bundled and none uses full-screen PNGs',
    () {
      final source = File(
        'assets/stitch/sources.json',
      ).readAsStringSync().replaceFirst('\uFEFF', '');
      final images = jsonDecode(source) as List<dynamic>;
      expect(images.length, 9);
      for (final image in images) {
        expect(File(image['file'] as String).existsSync(), isTrue);
      }
      for (final file
          in Directory('lib')
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.dart'))) {
        final source = file.readAsStringSync();
        expect(source.contains('screen.png'), isFalse, reason: file.path);
        expect(source.contains('Image.network('), isFalse, reason: file.path);
      }
    },
  );
}
