import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import '../journal/mood_selector.dart';

class WellnessHubScreen extends ConsumerWidget {
  const WellnessHubScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    return PageFrame(
      title: l.wellness,
      back: false,
      children: [
        Text(
          '${l.waxing} · ${l.quietRestore}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        PhotoCard(
          asset: 'assets/stitch/8__wellness_hub_1.jpg',
          title: l.moonriseMeditation,
          subtitle: '12 ${l.minutes} · ${l.guided}',
          tag: l.featuredRitual,
          height: 190,
          onTap: () => context.push('/meditation/moonrise'),
        ),
        const SizedBox(height: 12),
        Text(l.audioUnavailable, style: Theme.of(context).textTheme.bodySmall),
        SectionTitle(
          l.breathingExercises,
          action: l.seeAll,
          onAction: () => context.push('/breathing'),
        ),
        AdaptiveGrid(
          children: [
            FeatureTile(
              icon: Icons.air,
              title: l.calmBreath,
              subtitle: l.calmBreathBody,
              onTap: () => context.push('/breathing?pattern=calm'),
            ),
            FeatureTile(
              icon: Icons.crop_square,
              title: l.boxBreathing,
              subtitle: l.boxBody,
              onTap: () => context.push('/breathing?pattern=box'),
            ),
          ],
        ),
        const SizedBox(height: 28),
        StitchCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.journalMood,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(l.energyQuestion),
              const SizedBox(height: 16),
              const MoodSelector(),
              const SizedBox(height: 20),
              PrimaryButton(
                label: l.writeEntry,
                onPressed: () => context.push('/journal/new'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        StitchCard(
          onTap: () => context.push('/community'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Kicker(l.communityReflections),
              const SizedBox(height: 16),
              Text(
                l.communityQuote,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Text(
                l.communityPreview,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.push('/community'),
                child: Text(l.readMore),
              ),
            ],
          ),
        ),
        SectionTitle(l.meditationLibrary),
        SecondaryButton(
          label: l.explore,
          onPressed: () => context.push('/meditations'),
        ),
        const SizedBox(height: 20),
        const DemoNotice(),
      ],
    );
  }
}
