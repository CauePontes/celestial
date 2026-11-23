import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});
  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<DiscoverScreen> {
  String query = '';
  int category = 0;
  bool onlySaved = false;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final entries = [
      (l.horoscope, '/horoscope', Icons.auto_awesome_outlined, 1),
      (l.birthChart, '/birth-chart', Icons.radar_outlined, 1),
      (l.zodiacExplore, '/zodiac', Icons.blur_circular_outlined, 1),
      (l.numerology, '/numerology', Icons.tag, 1),
      (l.cosmicCalendar, '/calendar', Icons.calendar_month_outlined, 1),
      (l.compatibility, '/partner-details', Icons.favorite_border, 2),
      (l.meditationLibrary, '/meditations', Icons.spa_outlined, 3),
      (l.breathingExercises, '/breathing', Icons.air, 3),
      (l.journal, '/journal', Icons.edit_note, 3),
      (l.community, '/community', Icons.people_outline, 3),
      (l.plus, '/premium', Icons.workspace_premium_outlined, 0),
      (l.achievements, '/achievements', Icons.emoji_events_outlined, 0),
    ];
    final saved = ref.watch(prototypeProvider).saved;
    final visible = entries
        .where(
          (e) =>
              e.$1.toLowerCase().contains(query.toLowerCase()) &&
              (category == 0 || e.$4 == category) &&
              (!onlySaved || saved.contains('feature-${e.$2}')),
        )
        .toList();
    return PageFrame(
      title: l.discover,
      children: [
        TextField(
          onChanged: (v) => setState(() => query = v),
          decoration: InputDecoration(
            labelText: l.search,
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 16),
        FilterStrip(
          labels: [l.all, l.astrology, l.love, l.wellness],
          selected: category,
          onSelected: (i) => setState(() => category = i),
        ),
        SwitchListTile(
          title: Text(l.favorites),
          value: onlySaved,
          onChanged: (v) => setState(() => onlySaved = v),
        ),
        const SizedBox(height: 12),
        if (visible.isEmpty)
          EmptyState(title: l.noResults, body: l.noEntriesBody),
        for (final e in visible)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StitchCard(
              padding: 0,
              child: MenuRow(
                icon: e.$3,
                title: e.$1,
                onTap: () => context.push(e.$2),
                trailing: IconButton(
                  tooltip: l.save,
                  onPressed: () => ref
                      .read(prototypeProvider.notifier)
                      .toggleSaved('feature-${e.$2}'),
                  icon: Icon(
                    saved.contains('feature-${e.$2}')
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
