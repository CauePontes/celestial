import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/stitch_layout.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l, s = ref.watch(prototypeProvider);
    final titles = [
      l.achievementOne,
      l.achievementTwo,
      l.achievementThree,
      l.achievementFour,
      l.achievementFive,
      l.achievementSix,
    ];
    final progress = [
      s.profile.name.isEmpty ? 0.0 : 1.0,
      (s.breathingCycles / 3).clamp(0.0, 1.0),
      (s.journal.length / 3).clamp(0.0, 1.0),
      (s.readingCount / 3).clamp(0.0, 1.0),
      (s.posts.length / 2).clamp(0.0, 1.0),
      (s.saved.length / 5).clamp(0.0, 1.0),
    ];
    return PageFrame(
      title: l.achievements,
      children: [
        Text(l.demoOnly),
        const SizedBox(height: 24),
        AdaptiveGrid(
          children: [
            for (var i = 0; i < 6; i++)
              StitchCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      progress[i] >= 1
                          ? Icons.emoji_events_outlined
                          : Icons.lock_outline,
                      color: progress[i] >= 1
                          ? AppColors.gold
                          : AppColors.lavender,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      titles[i],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.achievementBody,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress[i],
                      color: AppColors.lavender,
                      backgroundColor: AppColors.surfaceElevated,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      progress[i] >= 1 ? l.unlocked : l.inProgress,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
