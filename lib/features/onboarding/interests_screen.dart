import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class InterestsScreen extends ConsumerWidget {
  const InterestsScreen({super.key, this.edit = false});
  final bool edit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l,
        selected = ref.watch(prototypeProvider.select((s) => s.interests));
    final items = [
      (Icons.nights_stay_outlined, l.astrology, l.astrologyInterest),
      (Icons.favorite_border, l.relationships, l.relationshipsInterest),
      (Icons.auto_awesome_outlined, l.numerology, l.numerologyInterest),
      (Icons.self_improvement, l.meditate, l.meditationInterest),
      (Icons.edit_note, l.journaling, l.journalInterest),
    ];
    return PageFrame(
      title: edit ? l.preferencesSettings : l.stepTwo,
      actions: const [],
      children: [
        const SizedBox(height: 20),
        Text(
          l.interestsTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Text(l.interestsBody),
        const SizedBox(height: 28),
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Semantics(
              selected: selected.contains(i),
              button: true,
              child: StitchCard(
                elevated: selected.contains(i),
                onTap: () =>
                    ref.read(prototypeProvider.notifier).toggleInterest(i),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: selected.contains(i)
                          ? AppColors.primary
                          : AppColors.surfaceElevated,
                      child: Icon(
                        items[i].$1,
                        color: selected.contains(i)
                            ? AppColors.textPrimary
                            : AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[i].$2,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            items[i].$3,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      selected.contains(i)
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: AppColors.lavender,
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: edit ? l.save : l.enterCelestial,
          onPressed: selected.isEmpty
              ? null
              : () => edit && context.canPop()
                    ? context.pop()
                    : context.go('/home'),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            selected.isEmpty
                ? l.selectArea
                : '${selected.length} ${l.areasSelected}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
