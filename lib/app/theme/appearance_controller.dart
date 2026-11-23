import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../localization/locale_controller.dart';

final appearanceProvider = NotifierProvider<AppearanceController, bool>(
  AppearanceController.new,
);

class AppearanceController extends Notifier<bool> {
  @override
  bool build() => ref.read(preferencesProvider).getBool('soft_dusk') ?? false;
  Future<void> select(bool value) async {
    await ref.read(preferencesProvider).setBool('soft_dusk', value);
    state = value;
  }
}
