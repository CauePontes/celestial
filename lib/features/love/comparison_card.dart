import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/stitch_layout.dart';

class ComparisonCard extends ConsumerWidget {
  const ComparisonCard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l, state = ref.watch(prototypeProvider);
    final first = state.profile.name.isEmpty
        ? l.sampleName
        : state.profile.name;
    final second = state.partner.name.isEmpty
        ? l.samplePartner
        : state.partner.name;
    return StitchCard(
      onTap: () => context.push('/compatibility-report'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(first.characters.first),
              ),
              Transform.translate(
                offset: const Offset(-8, 0),
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF5C481F),
                  child: Text(
                    second.characters.first,
                    style: const TextStyle(color: AppColors.gold),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '$first & $second',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Kicker('84% · ${l.harmony}'),
          const SizedBox(height: 16),
          for (var i = 0; i < 3; i++) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    [l.communication, l.emotional, l.values][i],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Text(
                  const ['88%', '91%', '74%'][i],
                  style: const TextStyle(
                    color: AppColors.lavender,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: const [.88, .91, .74][i],
              backgroundColor: AppColors.surfaceElevated,
              color: i == 1 ? AppColors.gold : AppColors.lavender,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            l.relationshipNote,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Text(l.comparisonDemo, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
