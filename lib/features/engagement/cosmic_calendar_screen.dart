import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/catalog_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class CosmicCalendarScreen extends ConsumerStatefulWidget {
  const CosmicCalendarScreen({super.key, this.initialMonth});
  final DateTime? initialMonth;
  @override
  ConsumerState<CosmicCalendarScreen> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<CosmicCalendarScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.initialMonth != null) {
      month = DateTime(widget.initialMonth!.year, widget.initialMonth!.month);
    }
  }

  DateTime month = DateTime(DateTime.now().year, DateTime.now().month);
  int? selectedDay;
  int filter = 0;
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final events = ref.watch(catalogRepositoryProvider).events(l, month);
    final visible = events
        .where(
          (e) =>
              (filter == 0 || e.category == EventCategory.values[filter - 1]) &&
              (selectedDay == null || e.date.day == selectedDay),
        )
        .toList();
    return PageFrame(
      title: l.cosmicCalendar,
      children: [
        Row(
          children: [
            IconButton(
              tooltip: l.previous,
              onPressed: () => _move(-1),
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                DateFormat.yMMMM(l.localeName).format(month),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: l.nextDate,
              onPressed: () => _move(1),
              icon: const Icon(Icons.chevron_right),
            ),
            IconButton(
              tooltip: l.cosmicCalendar,
              onPressed: () => setState(() => expanded = !expanded),
              icon: Icon(
                expanded
                    ? Icons.view_week_outlined
                    : Icons.calendar_month_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DemoNotice(text: l.calendarDemo),
        const SizedBox(height: 20),
        if (expanded)
          _MonthGrid(
            month: month,
            selected: selectedDay,
            onSelected: (day) => setState(() => selectedDay = day),
          ),
        if (!expanded)
          SizedBox(
            height:
                104 +
                (MediaQuery.textScalerOf(context).scale(16) - 16).clamp(0, 32) *
                    3,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              separatorBuilder: (_, i) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final anchor = DateTime(
                  month.year,
                  month.month,
                  selectedDay ?? 14,
                );
                final day = anchor
                    .subtract(Duration(days: anchor.weekday - 1))
                    .add(Duration(days: i));
                return SizedBox(
                  width: 52 * MediaQuery.textScalerOf(context).scale(1),
                  child: StitchCard(
                    elevated: selectedDay == day.day,
                    padding: 8,
                    onTap: () => setState(() {
                      month = DateTime(day.year, day.month);
                      selectedDay = day.day;
                    }),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.E(l.localeName).format(day),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        Icon(
                          i % 2 == 0
                              ? Icons.nightlight_round
                              : Icons.brightness_3,
                          size: 18,
                          color: i == 4 ? AppColors.gold : AppColors.lavender,
                        ),
                        const SizedBox(height: 8),
                        Text('${day.day}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        const SizedBox(height: 20),
        FilterStrip(
          labels: [
            l.allEvents,
            l.moonPhases,
            l.planetaryTransits,
            l.personalAspects,
          ],
          selected: filter,
          onSelected: (i) => setState(() => filter = i),
        ),
        SectionTitle(
          l.celestialShifts,
          action: selectedDay == null ? l.monthEvents : l.dayEvents,
        ),
        if (selectedDay != null)
          TextButton(
            onPressed: () => setState(() => selectedDay = null),
            child: Text(l.clearDay),
          ),
        if (visible.isEmpty)
          EmptyState(title: l.noDayEvents, body: l.noDayEventsBody),
        for (final e in visible)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CalendarEventCard(event: e),
          ),
        const SizedBox(height: 12),
        StitchCard(
          elevated: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.celestialSync,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(l.syncUnavailable),
              const SizedBox(height: 20),
              PrimaryButton(label: l.syncDisabled),
            ],
          ),
        ),
      ],
    );
  }

  void _move(int value) => setState(() {
    month = DateTime(month.year, month.month + value);
    selectedDay = null;
  });
}

class CalendarEventCard extends ConsumerWidget {
  const CalendarEventCard({super.key, required this.event});
  final CosmicEvent event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(
      prototypeProvider.select((s) => s.saved.contains('event-${event.id}')),
    );
    return StitchCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              Kicker(
                DateFormat.MMMd(
                  context.l.localeName,
                ).add_jm().format(event.date),
              ),
              const PreviewBadge(),
            ],
          ),
          const SizedBox(height: 12),
          Text(event.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(event.body),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  event.badge,
                  style: const TextStyle(color: AppColors.gold, fontSize: 12),
                ),
              ),
              TextButton.icon(
                onPressed: () => ref
                    .read(prototypeProvider.notifier)
                    .toggleSaved('event-${event.id}'),
                icon: Icon(
                  saved ? Icons.bookmark : Icons.bookmark_border,
                  size: 16,
                ),
                label: Text(saved ? context.l.saved : context.l.save),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.selected,
    required this.onSelected,
  });
  final DateTime month;
  final int? selected;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final width = math.max(
        c.maxWidth,
        308.0 * MediaQuery.textScalerOf(context).scale(1),
      );
      final offset = (month.weekday - 1) % 7;
      final days = DateTime(month.year, month.month + 1, 0).day;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: width,
          child: Wrap(
            children: [
              for (var i = 0; i < 7; i++)
                SizedBox(
                  width: width / 7,
                  height: 40,
                  child: Center(
                    child: Text(
                      DateFormat.E(
                        context.l.localeName,
                      ).format(DateTime(2024, 1, 1 + i)),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              for (var i = 0; i < offset; i++)
                SizedBox(width: width / 7, height: 44),
              for (var day = 1; day <= days; day++)
                SizedBox(
                  width: width / 7,
                  height: 48 * MediaQuery.textScalerOf(context).scale(1),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: selected == day
                          ? AppColors.primary
                          : null,
                      foregroundColor: AppColors.textPrimary,
                    ),
                    onPressed: () => onSelected(day),
                    child: Text('$day'),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}
