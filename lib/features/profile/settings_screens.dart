import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/localization/locale_controller.dart';
import '../../app/theme/appearance_controller.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/stitch_layout.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final state = ref.watch(prototypeProvider),
        dusk = ref.watch(appearanceProvider);
    return PageFrame(
      title: l.settings,
      children: [
        SectionTitle(l.theme),
        StitchCard(
          padding: 4,
          child: RadioGroup<bool>(
            groupValue: dusk,
            onChanged: (v) async {
              try {
                await ref.read(appearanceProvider.notifier).select(v ?? false);
              } catch (_) {
                if (context.mounted) showMessage(context, l.saveError);
              }
            },
            child: Column(
              children: [
                RadioListTile(value: false, title: Text(l.themeDark)),
                RadioListTile(
                  value: true,
                  title: Text(l.themeDusk),
                  subtitle: Text(l.themeBody),
                ),
              ],
            ),
          ),
        ),
        SectionTitle(l.houseSystem),
        Text(l.houseSystemBody),
        const SizedBox(height: 12),
        StitchCard(
          padding: 4,
          child: RadioGroup<int>(
            groupValue: state.houseSystem,
            onChanged: (i) =>
                ref.read(prototypeProvider.notifier).setHouseSystem(i ?? 0),
            child: Column(
              children: [
                RadioListTile(value: 0, title: Text(l.placidus)),
                RadioListTile(value: 1, title: Text(l.wholeSign)),
              ],
            ),
          ),
        ),
        SectionTitle(l.notificationsSetting),
        StitchCard(
          padding: 0,
          child: SwitchListTile(
            title: Text(l.dailyNotification),
            subtitle: Text(l.notificationDemo),
            value: state.reminders,
            onChanged: ref.read(prototypeProvider.notifier).setReminders,
          ),
        ),
        SectionTitle(l.preferencesSettings),
        StitchCard(
          padding: 0,
          child: Column(
            children: [
              MenuRow(
                icon: Icons.translate,
                title: l.language,
                onTap: () => context.push('/language'),
              ),
              MenuRow(
                icon: Icons.interests_outlined,
                title: l.interestsTitle,
                onTap: () => context.push('/interests?edit=true'),
              ),
              MenuRow(
                icon: Icons.privacy_tip_outlined,
                title: l.privacyVault,
                onTap: () => context.push('/privacy'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final selected = ref.watch(localeProvider)?.languageCode ?? 'device';
    return PageFrame(
      title: l.language,
      children: [
        Text(l.languageHelp),
        const SizedBox(height: 24),
        StitchCard(
          padding: 8,
          child: RadioGroup<String>(
            groupValue: selected,
            onChanged: (v) async {
              try {
                await ref
                    .read(localeProvider.notifier)
                    .select(v == 'device' ? null : v);
              } catch (_) {
                if (context.mounted) showMessage(context, l.saveError);
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
      ],
    );
  }
}

class PrivacyHelpScreen extends StatelessWidget {
  const PrivacyHelpScreen({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.privacyVault,
    children: [
      Text(
        context.l.privacyTitle,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 24),
      Text(context.l.privacyBody),
      SectionTitle(context.l.privacy),
      StitchCard(child: Text(context.l.legalPlaceholder)),
      SectionTitle(context.l.support),
      Text(context.l.supportBody),
    ],
  );
}
