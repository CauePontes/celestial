import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/interpretation_repository.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/preview_sheet.dart';
import '../../l10n/app_localizations.dart';
import 'astrology_hero_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l.morning
        : (hour < 18 ? l.afternoon : l.evening);
    final insight = ref.watch(interpretationRepositoryProvider).getHoroscope(l);
    return CelestialScaffold(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l.appName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(letterSpacing: 2),
              ),
            ),
            IconButton(
              tooltip: l.notifications,
              icon: const Icon(Icons.notifications_none_outlined),
              onPressed: () => showFeaturePreview(
                context,
                l.notifications,
                body: l.notificationsBody,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(greeting, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(l.homeSubtitle, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 24),
        AstrologyHeroCard(onPressed: () => context.go('/astrology')),
        const SizedBox(height: 20),
        const DemoNotice(),
        const SizedBox(height: 24),
        InsightCard(title: insight.title, body: insight.body),
        SectionHeader(l.yourRituals),
        LayoutBuilder(
          builder: (context, constraints) {
            final items = [
              (Icons.auto_awesome_outlined, l.horoscope, '/astrology'),
              (Icons.radar_outlined, l.birthChart, '/astrology'),
              (Icons.favorite_border, l.compatibility, '/love'),
              (Icons.spa_outlined, l.meditate, '/wellness'),
            ];
            final narrow =
                constraints.maxWidth < 300 ||
                MediaQuery.textScalerOf(context).scale(16) > 24;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final item in items)
                  SizedBox(
                    width: narrow
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 12) / 2,
                    child: FeatureTile(
                      icon: item.$1,
                      title: item.$2,
                      onTap: () => context.go(item.$3),
                    ),
                  ),
              ],
            );
          },
        ),
        SectionHeader(l.exploreMore),
        SurfaceCard(
          padding: 4,
          child: Column(
            children: [
              for (final item in [
                (Icons.tag, l.numerology),
                (Icons.book_outlined, l.journal),
                (Icons.people_outline, l.community),
              ])
                ListTile(
                  leading: Icon(item.$1, color: AppColors.lavender),
                  title: Text(item.$2),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showFeaturePreview(context, item.$2),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SurfaceCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.brightness_4_outlined, color: AppColors.gold),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.premium,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.premiumBody,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.comingLater,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
