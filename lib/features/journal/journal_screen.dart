import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import 'mood_selector.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final entries = ref.watch(prototypeProvider.select((s) => s.journal));
    return PageFrame(
      title: l.journalTitle,
      children: [
        const MoodSelector(),
        const SizedBox(height: 20),
        Text(l.journalPrompt),
        const SizedBox(height: 24),
        PrimaryButton(
          label: l.newEntry,
          onPressed: () => context.push('/journal/new'),
        ),
        const SizedBox(height: 24),
        if (entries.isEmpty)
          EmptyState(title: l.journalEmpty, body: l.journalEmptyBody),
        for (final e in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: StitchCard(
              onTap: () => context.push('/journal/${e.id}/edit'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Kicker(DateFormat.yMMMd(l.localeName).format(e.date)),
                  const SizedBox(height: 8),
                  Text(e.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(e.body, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 12),
                  Text(
                    [l.calm, l.reflective, l.grounded, l.energized][e.mood],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 16),
        DemoNotice(text: l.demoOnly),
      ],
    );
  }
}
