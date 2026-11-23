import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/catalog_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/celestial_badges.dart';
import 'astrology_hero_card.dart';
import '../../core/widgets/stitch_layout.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final state = ref.watch(prototypeProvider);
    final now = DateTime.now(), hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l.greetingMorning
        : (hour < 18 ? l.greetingAfternoon : l.greetingEvening);
    final name = state.profile.name.trim().isEmpty
        ? l.explorer
        : state.profile.name.split(' ').first;
    final events = ref
        .watch(catalogRepositoryProvider)
        .events(l, DateTime(now.year, now.month));
    return PageFrame(
      title: l.home,
      back: false,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ZodiacBadge(label: l.sampleSunMoon),
            const PreviewBadge(),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          '$greeting, $name',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 28),
        const AstrologyHeroCard(),
        const SizedBox(height: 24),
        StitchCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.surfaceElevated,
                child: Icon(
                  Icons.auto_awesome_outlined,
                  color: AppColors.gold,
                  size: 19,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Kicker(l.insightTitle),
                    const SizedBox(height: 8),
                    Text(
                      l.insightQuote,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SectionTitle(l.sanctuary, action: l.quickAccess),
        AdaptiveGrid(
          children: [
            FeatureTile(
              icon: Icons.flare_outlined,
              title: l.birthChart,
              subtitle: l.housesAspects,
              onTap: () => context.push('/birth-chart'),
            ),
            FeatureTile(
              icon: Icons.tag,
              title: l.numerology,
              subtitle: l.lifePathSeven,
              onTap: () => context.push('/numerology'),
            ),
            FeatureTile(
              icon: Icons.air,
              title: l.breathing,
              subtitle: l.calmBreath,
              onTap: () => context.push('/breathing'),
            ),
            FeatureTile(
              icon: Icons.edit_note,
              title: l.journal,
              subtitle: l.eveningReflection,
              onTap: () => context.push('/journal'),
            ),
          ],
        ),
        SectionTitle(
          l.cosmicCalendar,
          action: l.viewAll,
          onAction: () => context.push('/calendar'),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final event in events)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    width: 250,
                    child: StitchCard(
                      onTap: () => context.push('/calendar'),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Kicker(
                            DateFormat.MMMd(l.localeName).format(event.date),
                          ),
                          const SizedBox(height: 12),
                          Text(event.title),
                          const SizedBox(height: 4),
                          Text(
                            l.preview,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        StitchCard(
          gradient: true,
          onTap: () => context.push('/premium'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Kicker(l.plusHome),
              const SizedBox(height: 8),
              Text(l.plusSummary),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => context.push('/premium'),
                child: Text(l.explore),
              ),
            ],
          ),
        ),
        SectionTitle(l.exploreMore),
        StitchCard(
          padding: 0,
          child: Column(
            children: [
              MenuRow(
                icon: Icons.explore_outlined,
                title: l.discover,
                onTap: () => context.push('/discover'),
              ),
              MenuRow(
                icon: Icons.people_outline,
                title: l.community,
                onTap: () => context.push('/community'),
              ),
              MenuRow(
                icon: Icons.favorite_border,
                title: l.compatibility,
                onTap: () => context.go('/love'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const DemoNotice(),
      ],
    );
  }
}
