import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/demo/interpretation_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class CompatibilityReportScreen extends ConsumerWidget {
  const CompatibilityReportScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final intro = ref
        .watch(interpretationRepositoryProvider)
        .getCompatibilityInterpretation(l);
    return PageFrame(
      title: l.compatibilityReport,
      children: [
        const PreviewBadge(),
        const SizedBox(height: 20),
        Text(l.comparisonDemo),
        const SizedBox(height: 20),
        Text(intro.body),
        for (final section in [
          (l.communication, l.communicationBody),
          (l.emotional, l.emotionalBody),
          (l.values, l.valuesBody),
        ]) ...[SectionTitle(section.$1), StitchCard(child: Text(section.$2))],
        const SizedBox(height: 24),
        PrimaryButton(
          label:
              ref
                  .watch(prototypeProvider)
                  .saved
                  .contains('compatibility-report')
              ? l.saved
              : l.save,
          onPressed: () => ref
              .read(prototypeProvider.notifier)
              .toggleSaved('compatibility-report'),
        ),
      ],
    );
  }
}
