import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/date_selector.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/interpretation_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/catalog_view.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class HoroscopeScreen extends ConsumerStatefulWidget {
  const HoroscopeScreen({
    super.key,
    this.initialSign = 6,
    this.initialPeriod = 0,
    this.initialDate,
  });
  final int initialSign;
  final int initialPeriod;
  final DateTime? initialDate;
  @override
  ConsumerState<HoroscopeScreen> createState() => _HoroscopeState();
}

class _HoroscopeState extends ConsumerState<HoroscopeScreen> {
  int period = 0, category = 0;
  late int sign;
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    sign = widget.initialSign.clamp(0, 11);
    period = widget.initialPeriod.clamp(0, 2);
    date = widget.initialDate ?? DateTime.now();
    Future.microtask(
      () => ref.read(prototypeProvider.notifier).recordReading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final reading = ref
        .watch(interpretationRepositoryProvider)
        .getReading(l, period);
    final id = 'horoscope-$sign-$period-${date.year}-${date.month}-${date.day}';
    final saved = ref.watch(
      prototypeProvider.select((s) => s.saved.contains(id)),
    );
    final categories = [
      l.all,
      l.loveCategory,
      l.careerCategory,
      l.wellnessCategory,
    ];
    final cards = [
      (Icons.favorite_border, l.loveCategory, reading.love),
      (Icons.explore_outlined, l.careerCategory, reading.career),
      (Icons.spa_outlined, l.wellnessCategory, reading.wellness),
    ];
    return PageFrame(
      title: l.horoscopeDetails,
      children: [
        FilterStrip(
          labels: [l.daily, l.weekly, l.monthly],
          selected: period,
          onSelected: (i) => setState(() => period = i),
        ),
        const SizedBox(height: 20),
        DateSelector(
          date: date,
          onPrevious: () => _move(-1),
          onNext: () => _move(1),
          trailing: IconButton(
            tooltip: saved ? l.saved : l.save,
            onPressed: () =>
                ref.read(prototypeProvider.notifier).toggleSaved(id),
            icon: Icon(
              saved ? Icons.bookmark : Icons.bookmark_border,
              color: AppColors.lavender,
            ),
          ),
        ),
        const SizedBox(height: 12),
        CatalogView(
          builder: (catalog) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterStrip(
                labels: [for (final s in catalog.signs) s.name],
                selected: sign,
                onSelected: (i) => setState(() => sign = i),
              ),
              const SizedBox(height: 24),
              StitchCard(
                padding: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Kicker(
                      '${catalog.signs[sign].name} · ${catalog.signs[sign].element}',
                      gold: false,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      reading.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      reading.body,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const DemoNotice(),
        const SizedBox(height: 20),
        FilterStrip(
          labels: categories,
          selected: category,
          onSelected: (i) => setState(() => category = i),
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < cards.length; i++)
          if (category == 0 || category == i + 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: StitchCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(cards[i].$1, color: AppColors.gold),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            cards[i].$2,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(cards[i].$3),
                    const SizedBox(height: 16),
                    Text(
                      l.illustrativeReading,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  void _move(int direction) => setState(
    () => date = period == 2
        ? DateTime(date.year, date.month + direction, 1)
        : date.add(Duration(days: direction * (period == 1 ? 7 : 1))),
  );
}
