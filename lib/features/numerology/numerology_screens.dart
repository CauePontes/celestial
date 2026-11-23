import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/interpretation_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class NumerologyHubScreen extends StatelessWidget {
  const NumerologyHubScreen({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.numerology,
    children: [
      const PreviewBadge(),
      const SizedBox(height: 24),
      Text(
        context.l.numerologyHub,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 16),
      Text(context.l.lifePathPreview),
      const SizedBox(height: 24),
      StitchCard(
        gradient: true,
        onTap: () => context.push('/life-path'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.primary,
              child: Text(
                '7',
                style: TextStyle(fontFamily: 'Playfair Display', fontSize: 40),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l.lifePathSeven,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(context.l.seekerBody),
            const SizedBox(height: 20),
            PrimaryButton(
              label: context.l.lifePath,
              onPressed: () => context.push('/life-path'),
            ),
          ],
        ),
      ),
      SectionTitle(context.l.blueprint),
      AdaptiveGrid(
        children: [
          MetricTile(
            value: '3',
            label: context.l.expressionNumber,
            icon: Icons.auto_awesome_outlined,
          ),
          MetricTile(
            value: '9',
            label: context.l.heartNumber,
            icon: Icons.favorite_border,
          ),
        ],
      ),
      SectionTitle(context.l.cyclesTitle),
      StitchCard(
        onTap: () => context.push('/numerology-report'),
        child: Text(context.l.personalYear),
      ),
      const SizedBox(height: 24),
      PrimaryButton(
        label: context.l.readReport,
        onPressed: () => context.push('/numerology-report'),
      ),
    ],
  );
}

class LifePathScreen extends ConsumerStatefulWidget {
  const LifePathScreen({super.key});
  @override
  ConsumerState<LifePathScreen> createState() => _LifePathState();
}

class _LifePathState extends ConsumerState<LifePathScreen> {
  DateTime? date;
  bool show = false, error = false;
  @override
  void initState() {
    super.initState();
    date = ref.read(prototypeProvider).profile.birthDate;
  }

  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.lifePath,
    children: [
      Text(context.l.lifePathPreview),
      const SizedBox(height: 24),
      StitchCard(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime(1994, 10, 14),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() {
              date = picked;
              error = false;
              show = false;
            });
          }
        },
        child: MenuRow(
          icon: Icons.calendar_today_outlined,
          title: context.l.birthDate,
          subtitle: date == null
              ? context.l.chooseDate
              : DateFormat.yMd(context.l.localeName).format(date!),
        ),
      ),
      if (error)
        Text(
          context.l.requiredField,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      const SizedBox(height: 24),
      PrimaryButton(
        label: context.l.calculatePreview,
        onPressed: () => setState(() {
          error = date == null;
          show = date != null;
        }),
      ),
      if (show) ...[
        const SizedBox(height: 28),
        StitchCard(
          child: Column(
            children: [
              const PreviewBadge(),
              const SizedBox(height: 16),
              Text('7', style: Theme.of(context).textTheme.displaySmall),
              Text(context.l.lifePathSeven),
              const SizedBox(height: 16),
              Text(context.l.lifePathPreview),
              const SizedBox(height: 20),
              PrimaryButton(
                label: context.l.readReport,
                onPressed: () => context.push('/numerology-report'),
              ),
            ],
          ),
        ),
      ],
    ],
  );
}

class NumerologyReportScreen extends ConsumerWidget {
  const NumerologyReportScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l,
        reading = ref
            .watch(interpretationRepositoryProvider)
            .getNumerologyInterpretation(context.l);
    return PageFrame(
      title: l.numerologyReport,
      children: [
        const PreviewBadge(),
        const SizedBox(height: 24),
        Text(l.lifePathSeven, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 16),
        Text(l.lifePathPreview),
        for (final title in [
          l.lifePath,
          l.expressionNumber,
          l.heartNumber,
          l.cyclesTitle,
        ]) ...[SectionTitle(title), StitchCard(child: Text(reading.body))],
        const SizedBox(height: 24),
        PrimaryButton(
          label:
              ref.watch(prototypeProvider).saved.contains('numerology-report')
              ? l.saved
              : l.save,
          onPressed: () => ref
              .read(prototypeProvider.notifier)
              .toggleSaved('numerology-report'),
        ),
      ],
    );
  }
}
