import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({super.key, this.value, this.onChanged});
  final int? value;
  final ValueChanged<int>? onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final selected =
        value ?? ref.watch(prototypeProvider.select((s) => s.mood));
    final labels = [l.calm, l.reflective, l.grounded, l.energized];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < labels.length; i++)
          ChoiceChip(
            label: Text(labels[i]),
            selected: selected == i,
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surfaceElevated,
            labelStyle: TextStyle(
              color: selected == i
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
            showCheckmark: false,
            onSelected: (_) => onChanged != null
                ? onChanged!(i)
                : ref.read(prototypeProvider.notifier).setMood(i),
            side: BorderSide.none,
            shape: const StadiumBorder(),
          ),
      ],
    );
  }
}
