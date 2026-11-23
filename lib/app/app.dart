import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import 'localization/locale_controller.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class CelestialApp extends ConsumerWidget {
  const CelestialApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    onGenerateTitle: (context) => AppLocalizations.of(context).appName,
    theme: AppTheme.dark,
    locale: ref.watch(localeProvider),
    supportedLocales: const [Locale('en', 'US'), Locale('es', 'US')],
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    localeListResolutionCallback: resolveDeviceLocales,
    routerConfig: ref.watch(routerProvider),
  );
}
