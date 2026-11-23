import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/localization/locale_controller.dart';
import '../../app/theme/app_colors.dart';
import '../../core/widgets/components.dart';
import '../../l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider);
    return CelestialScaffold(
      children: [
        Text(l.profile, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 28),
        const Icon(
          Icons.account_circle_outlined,
          size: 56,
          color: AppColors.lavender,
        ),
        const SizedBox(height: 20),
        Text(l.profileTitle, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 16),
        Text(l.profileBody),
        const SizedBox(height: 24),
        SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PreviewBadge(),
              const SizedBox(height: 16),
              Text(l.guest, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(l.guestBody),
            ],
          ),
        ),
        SectionHeader(l.language),
        SurfaceCard(
          padding: 8,
          child: RadioGroup<String>(
            groupValue: locale?.languageCode ?? 'device',
            onChanged: (value) async {
              try {
                await ref
                    .read(localeProvider.notifier)
                    .select(value == 'device' ? null : value);
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context).saveError),
                    ),
                  );
                }
              }
            },
            child: Column(
              children: [
                RadioListTile(value: 'device', title: Text(l.deviceLanguage)),
                RadioListTile(value: 'en', title: Text(l.english)),
                RadioListTile(value: 'es', title: Text(l.spanish)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(l.languageHelp, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 24),
        const DemoNotice(),
      ],
    );
  }
}
