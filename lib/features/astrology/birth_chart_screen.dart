import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import 'natal_wheel.dart';

class BirthChartScreen extends StatefulWidget {
  const BirthChartScreen({super.key});
  @override
  State<BirthChartScreen> createState() => _BirthChartState();
}

class _BirthChartState extends State<BirthChartScreen> {
  int filter = 0;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return PageFrame(
      title: l.natalDeepDive,
      children: [
        const PreviewBadge(),
        const SizedBox(height: 12),
        DemoNotice(text: l.chartNotice),
        const SizedBox(height: 20),
        StitchCard(
          elevated: true,
          child: Column(
            children: [
              const NatalWheel(),
              const SizedBox(height: 12),
              Text(
                l.sampleBigThree,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FilterStrip(
          labels: [l.bigThree, l.planets, l.houses, l.aspects],
          selected: filter,
          onSelected: (i) => setState(() => filter = i),
        ),
        if (filter == 0) ...[
          SectionTitle(l.bigThree, action: l.coreArchetype),
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _PlacementCard(index: i),
            ),
          const SizedBox(height: 8),
          AdaptiveGrid(
            children: [
              PhotoCard(
                asset: 'assets/stitch/12__natal_chart_deep_dive_1.jpg',
                title: l.airWater,
                subtitle: l.primaryElement,
                height: 110,
                onTap: () => context.push('/chart-details'),
              ),
              PhotoCard(
                asset: 'assets/stitch/12__natal_chart_deep_dive_2.jpg',
                title: l.fixedCardinal,
                subtitle: l.modalBalance,
                height: 110,
                onTap: () => context.push('/chart-details'),
              ),
            ],
          ),
          SectionTitle(l.keyAspects),
          for (var i = 0; i < 2; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AspectCard(index: i),
            ),
          SectionTitle(
            l.housePreview,
            action: l.viewHouses,
            onAction: () => setState(() => filter = 2),
          ),
          StitchCard(
            padding: 0,
            child: Column(
              children: [
                for (final i in [0, 6, 9]) _HouseRow(index: i),
              ],
            ),
          ),
        ],
        if (filter == 1) ...[
          SectionTitle(l.planets),
          for (var i = 0; i < 10; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: StitchCard(
                padding: 0,
                child: MenuRow(
                  icon: Icons.blur_circular_outlined,
                  title: _planetNames(context)[i],
                  subtitle: l.illustrativeReading,
                  onTap: () => context.push('/planet/$i'),
                ),
              ),
            ),
        ],
        if (filter == 2) ...[
          SectionTitle(l.houses),
          StitchCard(
            padding: 0,
            child: Column(
              children: [for (var i = 0; i < 12; i++) _HouseRow(index: i)],
            ),
          ),
        ],
        if (filter == 3) ...[
          SectionTitle(l.keyAspects),
          for (var i = 0; i < 2; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AspectCard(index: i),
            ),
        ],
        const SizedBox(height: 24),
        PrimaryButton(
          label: l.chartDetails,
          onPressed: () => context.push('/chart-details'),
        ),
      ],
    );
  }
}

List<String> _planetNames(BuildContext c) => [
  c.l.sun,
  c.l.moon,
  c.l.mercury,
  c.l.venus,
  c.l.mars,
  c.l.jupiter,
  c.l.saturn,
  c.l.uranus,
  c.l.neptune,
  c.l.pluto,
];

class _PlacementCard extends StatelessWidget {
  const _PlacementCard({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final titles = [l.sunLibra, l.moonPisces, l.risingTaurus],
        bodies = [l.sunDescription, l.moonDescription, l.risingDescription];
    return StitchCard(
      onTap: () => context.push('/planet/$index'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(
                  const ['☉', '☽', '↑'][index],
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontFamily: 'Noto Symbols',
                    fontFamilyFallback: ['Noto Symbols2'],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  titles[index],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Kicker(
            '${l.preview} · ${const ["21°14′", "14°02′", "04°28′"][index]}',
          ),
          const SizedBox(height: 12),
          Text(bodies[index]),
        ],
      ),
    );
  }
}

class _AspectCard extends StatelessWidget {
  const _AspectCard({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) => StitchCard(
    onTap: () => context.push('/insight?kind=aspect&index=$index'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          index == 0 ? context.l.venusNeptune : context.l.sunMars,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Text(context.l.aspectDescription),
      ],
    ),
  );
}

class _HouseRow extends StatelessWidget {
  const _HouseRow({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) => MenuRow(
    icon: Icons.home_outlined,
    title: '${context.l.houses} ${index + 1}',
    subtitle: index == 0
        ? context.l.selfHouse
        : index == 6
        ? context.l.partnershipHouse
        : index == 9
        ? context.l.vocationHouse
        : context.l.houseMeaning,
    onTap: () => context.push('/insight?kind=house&index=$index'),
  );
}

class ChartDetailsScreen extends StatelessWidget {
  const ChartDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.chartDetails,
    children: [
      DemoNotice(text: context.l.chartNotice),
      SectionTitle(context.l.bigThree),
      for (var i = 0; i < 3; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _PlacementCard(index: i),
        ),
      SectionTitle(context.l.planets),
      StitchCard(
        padding: 0,
        child: Column(
          children: [
            for (var i = 0; i < 10; i++)
              MenuRow(
                icon: Icons.blur_circular_outlined,
                title: _planetNames(context)[i],
                onTap: () => context.push('/planet/$i'),
              ),
          ],
        ),
      ),
      SectionTitle(context.l.keyAspects),
      const _AspectCard(index: 0),
      const SizedBox(height: 16),
      const _AspectCard(index: 1),
    ],
  );
}
