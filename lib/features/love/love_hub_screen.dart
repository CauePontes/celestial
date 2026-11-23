import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/orbital_crest.dart';
import '../../core/widgets/stitch_layout.dart';
import 'comparison_card.dart';

class LoveHubScreen extends ConsumerWidget {
  const LoveHubScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    return PageFrame(
      title: l.love,
      back: false,
      children: [
        StitchCard(
          gradient: true,
          child: Column(
            children: [
              const OrbitalCrest(size: 180, connection: true),
              Kicker(l.synastry),
              const SizedBox(height: 12),
              Text(
                l.loveCompatibility,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              Text(l.loveHeroBody, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              PrimaryButton(
                label: l.compareCharts,
                onPressed: () => context.push('/partner-details'),
              ),
            ],
          ),
        ),
        SectionTitle(
          l.recentComparisons,
          action: l.viewAll,
          onAction: () => context.push('/compatibility-result'),
        ),
        const ComparisonCard(),
        SectionTitle(l.relationshipInsights, action: l.curated),
        PhotoCard(
          asset: 'assets/stitch/7__love_hub_1.jpg',
          title: l.venusTitle,
          subtitle: l.venusBody,
          tag: l.venusTransit,
          onTap: () => context.push('/relationship-insight?article=0'),
        ),
        const SizedBox(height: 16),
        PhotoCard(
          asset: 'assets/stitch/7__love_hub_2.jpg',
          title: l.moonMercuryTitle,
          subtitle: l.moonMercuryBody,
          tag: l.synastryTheme,
          onTap: () => context.push('/relationship-insight?article=1'),
        ),
        const SizedBox(height: 24),
        const DemoNotice(),
      ],
    );
  }
}

class CompatibilityResultScreen extends ConsumerWidget {
  const CompatibilityResultScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => PageFrame(
    title: context.l.comparisonResult,
    children: [
      const Center(child: OrbitalCrest(size: 180, connection: true)),
      Text(context.l.comparisonDemo),
      const SizedBox(height: 20),
      const ComparisonCard(),
      const SizedBox(height: 24),
      PrimaryButton(
        label: context.l.readReport,
        onPressed: () => context.push('/compatibility-report'),
      ),
      const SizedBox(height: 12),
      SecondaryButton(
        label: context.l.partnerDetails,
        onPressed: () => context.push('/partner-details'),
      ),
      const SizedBox(height: 12),
      SecondaryButton(
        label: context.l.editProfile,
        onPressed: () => context.push('/edit-profile'),
      ),
    ],
  );
}

class RelationshipInsightScreen extends StatelessWidget {
  const RelationshipInsightScreen({super.key, this.article = 0});
  final int article;
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.relationshipInsights,
    children: [
      PhotoCard(
        asset: article == 0
            ? 'assets/stitch/7__love_hub_1.jpg'
            : 'assets/stitch/7__love_hub_2.jpg',
        title: article == 0 ? context.l.venusTitle : context.l.moonMercuryTitle,
        subtitle: article == 0
            ? context.l.venusBody
            : context.l.moonMercuryBody,
      ),
      SectionTitle(context.l.communication),
      Text(context.l.communicationBody),
      SectionTitle(context.l.emotional),
      Text(context.l.emotionalBody),
      const SizedBox(height: 24),
      const PreviewBadge(),
    ],
  );
}
