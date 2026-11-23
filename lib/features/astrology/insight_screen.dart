import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/demo/interpretation_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class AstrologicalInsightScreen extends ConsumerWidget {
  const AstrologicalInsightScreen({
    super.key,
    this.kind = 'general',
    this.index = 0,
  });
  final String kind;
  final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l, id = 'insight-$kind-$index';
    final interpretation = ref
        .watch(interpretationRepositoryProvider)
        .getBirthChartInterpretation(l);
    final saved = ref.watch(
      prototypeProvider.select((s) => s.saved.contains(id)),
    );
    final title = kind == 'house'
        ? '${l.houses} ${index + 1}'
        : kind == 'aspect'
        ? (index == 0 ? l.venusNeptune : l.sunMars)
        : l.insight;
    return PageFrame(
      title: title,
      children: [
        const PreviewBadge(),
        const SizedBox(height: 24),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 20),
        Text(kind == 'house' ? l.houseMeaning : l.aspectDescription),
        const SizedBox(height: 24),
        Text(interpretation.body),
        const SizedBox(height: 24),
        PrimaryButton(
          label: saved ? l.saved : l.save,
          onPressed: () => ref.read(prototypeProvider.notifier).toggleSaved(id),
        ),
      ],
    );
  }
}

class PlanetDetailScreen extends StatelessWidget {
  const PlanetDetailScreen({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final names = [
      l.sun,
      l.moon,
      l.mercury,
      l.venus,
      l.mars,
      l.jupiter,
      l.saturn,
      l.uranus,
      l.neptune,
      l.pluto,
    ];
    return PageFrame(
      title: names[index.clamp(0, 9)],
      children: [
        const PreviewBadge(),
        const SizedBox(height: 24),
        Text(l.planetDetail, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 24),
        StitchCard(
          child: Text(
            index == 0
                ? l.sunDescription
                : index == 1
                ? l.moonDescription
                : l.aspectDescription,
          ),
        ),
        SectionTitle(l.insight),
        Text(l.houseMeaning),
        const SizedBox(height: 24),
        const DemoNotice(),
      ],
    );
  }
}
