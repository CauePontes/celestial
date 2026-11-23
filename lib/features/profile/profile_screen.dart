import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/demo_session.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/celestial_badges.dart';
import '../../core/widgets/stitch_layout.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final state = ref.watch(prototypeProvider);
    final p = ref.watch(demoSessionProvider).profile;
    final name = p.name.isEmpty ? l.sampleName : p.name;
    final date = p.birthDate == null
        ? l.noAccount
        : DateFormat.yMMMd(l.localeName).format(p.birthDate!);
    final birthTime = p.birthMinutes == null
        ? ''
        : MaterialLocalizations.of(context).formatTimeOfDay(
            TimeOfDay(
              hour: p.birthMinutes! ~/ 60,
              minute: p.birthMinutes! % 60,
            ),
            alwaysUse24HourFormat: false,
          );
    return PageFrame(
      title: l.profile,
      back: false,
      children: [
        StitchCard(
          gradient: true,
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  PremiumBadge(label: l.celestialMember),
                  TextButton(
                    onPressed: () => context.push('/premium'),
                    child: Text('${l.upgrade} ↗'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.lavender.withValues(alpha: .5),
                  ),
                ),
                child: name == l.sampleName
                    ? ClipOval(
                        child: Image.asset(
                          'assets/stitch/9__profile_1.jpg',
                          height: 84,
                          width: 84,
                          fit: BoxFit.cover,
                          excludeFromSemantics: true,
                        ),
                      )
                    : CircleAvatar(
                        radius: 42,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          name.characters.first,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l.sampleBigThree,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.lavender, fontSize: 12),
              ),
              const SizedBox(height: 12),
              const PreviewBadge(),
              const SizedBox(height: 16),
              MenuRow(
                icon: Icons.hourglass_empty,
                title: date,
                subtitle: [
                  birthTime,
                  p.city,
                ].where((s) => s.isNotEmpty).join(' · '),
                onTap: () => context.push('/edit-profile'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        AdaptiveGrid(
          columns: 3,
          children: [
            MetricTile(
              value: '${state.readingCount}',
              label: l.insightsRead,
              icon: Icons.visibility_outlined,
            ),
            MetricTile(
              value: '${state.breathingCycles}',
              label: l.cycles,
              icon: Icons.spa_outlined,
            ),
            MetricTile(
              value: '${state.journal.length}',
              label: l.reflections,
              icon: Icons.auto_stories_outlined,
            ),
          ],
        ),
        SectionTitle(l.cosmicBlueprint, action: l.astrologicalData),
        StitchCard(
          padding: 0,
          child: Column(
            children: [
              MenuRow(
                icon: Icons.lens_blur,
                title: l.natalSummary,
                subtitle: l.natalSummaryBody,
                onTap: () => context.push('/birth-chart'),
              ),
              MenuRow(
                icon: Icons.all_inclusive,
                title: l.lifePathSeven,
                subtitle: l.seekerBody,
                onTap: () => context.push('/numerology-report'),
                gold: true,
              ),
              MenuRow(
                icon: Icons.history_toggle_off,
                title: l.transitArchive,
                subtitle: l.transitArchiveBody,
                onTap: () => context.push('/calendar'),
              ),
            ],
          ),
        ),
        SectionTitle(l.savedSanctuary, action: '${state.saved.length}'),
        StitchCard(
          padding: 0,
          child: Column(
            children: [
              MenuRow(
                icon: Icons.bookmark_border,
                title: l.savedHoroscopes,
                onTap: () => context.push('/favorites?type=horoscope'),
              ),
              MenuRow(
                icon: Icons.headphones_outlined,
                title: l.bookmarkedMeditations,
                onTap: () => context.push('/favorites?type=meditation'),
                gold: true,
              ),
              MenuRow(
                icon: Icons.sync_alt,
                title: l.relationshipCharts,
                onTap: () => context.push('/compatibility-result'),
              ),
              MenuRow(
                icon: Icons.emoji_events_outlined,
                title: l.achievements,
                onTap: () => context.push('/achievements'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        StitchCard(
          gradient: true,
          onTap: () => context.push('/premium'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Kicker(l.plus),
              const SizedBox(height: 8),
              Text(l.plusSummary),
              const SizedBox(height: 8),
              Text(
                l.paymentNotice,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        SectionTitle(l.preferencesSettings),
        StitchCard(
          padding: 0,
          child: Column(
            children: [
              SwitchListTile(
                title: Text(l.dailyNotification),
                subtitle: Text(
                  l.notificationDemo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                value: state.reminders,
                onChanged: ref.read(prototypeProvider.notifier).setReminders,
              ),
              MenuRow(
                icon: Icons.public,
                title: l.houseSystem,
                subtitle: state.houseSystem == 0 ? l.placidus : l.wholeSign,
                onTap: () => context.push('/settings'),
                gold: true,
              ),
              MenuRow(
                icon: Icons.translate,
                title: l.language,
                subtitle: l.languageSubtitle,
                onTap: () => context.push('/language'),
              ),
              MenuRow(
                icon: Icons.tune,
                title: l.settings,
                onTap: () => context.push('/settings'),
              ),
              MenuRow(
                icon: Icons.lock_outline,
                title: l.privacyVault,
                subtitle: l.privacyVaultBody,
                onTap: () => context.push('/privacy'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SecondaryButton(
          label: l.signOut,
          onPressed: () async {
            final yes = await showDialog<bool>(
              context: context,
              builder: (c) => AlertDialog(
                title: Text(l.confirmReset),
                content: Text(l.signOutBody),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(c, false),
                    child: Text(l.cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(c, true),
                    child: Text(l.resetDemo),
                  ),
                ],
              ),
            );
            if (yes == true && context.mounted) {
              ref.read(prototypeProvider.notifier).reset();
              context.go('/welcome');
            }
          },
        ),
        const SizedBox(height: 24),
        Center(
          child: Text(
            l.versionLabel,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            l.builtReverence,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
