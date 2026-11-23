import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/catalog_view.dart';
import '../../core/widgets/stitch_layout.dart';

class ZodiacSignsScreen extends StatelessWidget {
  const ZodiacSignsScreen({super.key});
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.zodiacExplore,
    children: [
      CatalogView(
        builder: (catalog) => AdaptiveGrid(
          children: [
            for (final s in catalog.signs)
              StitchCard(
                onTap: () => context.push('/horoscope?sign=${s.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.glyph,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontFamily: 'Noto Symbols'),
                    ),
                    const SizedBox(height: 12),
                    Text(s.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      '${s.element} · ${s.mode}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${DateFormat.MMMd(context.l.localeName).format(s.start)} – ${DateFormat.MMMd(context.l.localeName).format(s.end)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ],
  );
}
