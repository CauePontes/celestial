import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/catalog_view.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class MeditationLibraryScreen extends StatefulWidget {
  const MeditationLibraryScreen({super.key});
  @override
  State<MeditationLibraryScreen> createState() => _LibraryState();
}

class _LibraryState extends State<MeditationLibraryScreen> {
  int category = 0, duration = 0;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final filters = [l.all, l.sleep, l.calm, l.focus];
    return PageFrame(
      title: l.meditationLibrary,
      children: [
        FilterStrip(
          labels: filters,
          selected: category,
          onSelected: (i) => setState(() => category = i),
        ),
        const SizedBox(height: 12),
        FilterStrip(
          labels: [l.allDurations, l.shortSessions, l.longSessions],
          selected: duration,
          onSelected: (i) => setState(() => duration = i),
        ),
        const SizedBox(height: 24),
        CatalogView(
          builder: (catalog) {
            final sessions = catalog.meditations
                .where(
                  (s) =>
                      (category == 0 || s.category == filters[category]) &&
                      (duration == 0 ||
                          (duration == 1 ? s.minutes <= 10 : s.minutes > 10)),
                )
                .toList();
            if (sessions.isEmpty) {
              return EmptyState(title: l.noResults, body: l.noEntriesBody);
            }
            return Column(
              children: [
                for (final s in sessions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MeditationCard(meditation: s),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class MeditationCard extends StatelessWidget {
  const MeditationCard({super.key, required this.meditation});
  final Meditation meditation;
  @override
  Widget build(BuildContext context) => StitchCard(
    onTap: () => context.push('/meditation/${meditation.id}'),
    padding: 14,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            meditation.asset,
            width: 64,
            height: 78,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meditation.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '${meditation.minutes} ${context.l.minutes} · ${meditation.category}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, size: 20),
      ],
    ),
  );
}

class MeditationDetailsScreen extends ConsumerWidget {
  const MeditationDetailsScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) => PageFrame(
    title: context.l.meditate,
    children: [
      CatalogView(
        builder: (catalog) {
          final found = catalog.meditations.where((m) => m.id == id);
          if (found.isEmpty) {
            return EmptyState(
              title: context.l.noResults,
              body: context.l.noEntriesBody,
            );
          }
          final m = found.first;
          final l = context.l;
          final saved = ref
              .watch(prototypeProvider)
              .saved
              .contains('meditation-$id');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PhotoCard(
                asset: m.asset,
                title: m.title,
                subtitle: '${m.minutes} ${l.minutes} · ${m.category}',
                height: 210,
              ),
              const SizedBox(height: 24),
              Text(m.description),
              SectionTitle(l.yourRituals),
              Text(l.meditationGoals),
              const SizedBox(height: 24),
              DemoNotice(text: l.audioUnavailableBody),
              const SizedBox(height: 24),
              PrimaryButton(label: l.playAudio),
              const SizedBox(height: 12),
              SecondaryButton(
                label: l.viewPlayer,
                onPressed: () => context.push('/meditation-player/$id'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => ref
                    .read(prototypeProvider.notifier)
                    .toggleSaved('meditation-$id'),
                child: Text(saved ? l.saved : l.save),
              ),
            ],
          );
        },
      ),
    ],
  );
}

class MeditationPlayerScreen extends StatelessWidget {
  const MeditationPlayerScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.meditate,
    children: [
      CatalogView(
        builder: (catalog) {
          final found = catalog.meditations.where((m) => m.id == id);
          if (found.isEmpty) {
            return EmptyState(
              title: context.l.noResults,
              body: context.l.noEntriesBody,
            );
          }
          final m = found.first;
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  m.asset,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  excludeFromSemantics: true,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                m.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                context.l.audioUnavailable,
                style: const TextStyle(color: AppColors.gold),
              ),
              const SizedBox(height: 16),
              Text(context.l.audioUnavailableBody, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              const LinearProgressIndicator(
                value: 0,
                color: AppColors.lavender,
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.skip_previous)),
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.play_circle_outline, size: 54),
                  ),
                  IconButton(onPressed: null, icon: Icon(Icons.skip_next)),
                ],
              ),
            ],
          );
        },
      ),
    ],
  );
}
