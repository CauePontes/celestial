import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/catalog_repository.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/catalog_view.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import 'natal_wheel.dart';
import 'upcoming_event_tile.dart';

class AstrologyHubScreen extends ConsumerStatefulWidget {
  const AstrologyHubScreen({super.key});
  @override
  ConsumerState<AstrologyHubScreen> createState() => _AstrologyState();
}

class _AstrologyState extends ConsumerState<AstrologyHubScreen> {
  int placement = -1, sign = 6;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final events = ref
        .watch(catalogRepositoryProvider)
        .events(l, DateTime.now());
    return PageFrame(
      title: l.astrology,
      back: false,
      children: [
        StitchCard(
          gradient: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Kicker(l.blueprint)),
                  IconButton(
                    tooltip: l.chartDetails,
                    onPressed: () => context.push('/birth-chart'),
                    icon: const Icon(Icons.tune, size: 20),
                  ),
                ],
              ),
              Text(
                l.natalTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Center(
                child: NatalWheel(size: 280, selected: placement, simple: true),
              ),
              AdaptiveGrid(
                columns: 3,
                children: [
                  for (var i = 0; i < 3; i++)
                    PlanetChip(
                      label: [l.sun, l.moon, l.rising][i],
                      value: [l.libra, l.pisces, l.taurus][i],
                      selected: placement == i,
                      onTap: () => setState(() => placement = i),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              DemoNotice(text: l.chartNotice),
              const SizedBox(height: 12),
              PrimaryButton(
                label: l.natalDeepDive,
                onPressed: () => context.push('/birth-chart'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        StitchCard(
          onTap: () => context.push('/numerology'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Kicker(l.numerologyLife, gold: false),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.lifePathSeven,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 27,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      '7',
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 28,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(l.seekerBody),
              const SizedBox(height: 20),
              Text(
                l.personalYear,
                style: const TextStyle(color: AppColors.lavender),
              ),
            ],
          ),
        ),
        SectionTitle(
          l.upcoming,
          action: DateFormat.MMMM(l.localeName).format(DateTime.now()),
          onAction: () => context.push('/calendar'),
        ),
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: UpcomingEventTile(
              event: events[i],
              asset: i < 2
                  ? 'assets/stitch/5__astrology_hub_${i + 1}.jpg'
                  : null,
            ),
          ),
        SectionTitle(
          l.zodiacExplore,
          action: l.viewAll,
          onAction: () => context.push('/zodiac'),
        ),
        CatalogView(
          builder: (catalog) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterStrip(
                labels: [for (final s in catalog.signs) '${s.glyph} ${s.name}'],
                selected: sign,
                onSelected: (i) => setState(() => sign = i),
              ),
              const SizedBox(height: 12),
              Text(
                '${catalog.signs[sign].element} · ${catalog.signs[sign].mode}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                label: l.horoscope,
                onPressed: () => context.push('/horoscope?sign=$sign'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlanetChip extends StatelessWidget {
  const PlanetChip({
    super.key,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });
  final String label, value;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => StitchCard(
    elevated: !selected,
    padding: 12,
    onTap: onTap,
    child: Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.gold, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(value, textAlign: TextAlign.center),
      ],
    ),
  );
}
