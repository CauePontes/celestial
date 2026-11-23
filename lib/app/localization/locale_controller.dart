import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final preferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);
final localeProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale?> {
  static const preferenceKey = 'preferred_language';
  @override
  Locale? build() {
    final code = ref.read(preferencesProvider).getString(preferenceKey);
    return code == 'en' || code == 'es' ? Locale(code!, 'US') : null;
  }

  Future<void> select(String? code) async {
    final preferences = ref.read(preferencesProvider);
    if (code == null) {
      await preferences.remove(preferenceKey);
    } else {
      if (code != 'en' && code != 'es') return;
      await preferences.setString(preferenceKey, code);
    }
    state = code == null ? null : Locale(code, 'US');
  }
}

Locale resolveDeviceLocales(
  List<Locale>? preferred,
  Iterable<Locale> supported,
) {
  for (final locale in preferred ?? <Locale>[]) {
    if (locale.languageCode == 'es' || locale.languageCode == 'en') {
      return Locale(locale.languageCode, 'US');
    }
  }
  return const Locale('en', 'US');
}
