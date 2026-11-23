import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/orbit_art.dart';
import '../../l10n/app_localizations.dart';

enum PreviewFeature { astrology, love, wellness }

class FeaturePreviewScreen extends StatelessWidget {
  const FeaturePreviewScreen({super.key, required this.feature});
  final PreviewFeature feature;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final (label, title, body, style) = switch (feature) {
      PreviewFeature.astrology => (
        l.astrology,
        l.astrologyTitle,
        l.astrologyBody,
        OrbitStyle.zodiac,
      ),
      PreviewFeature.love => (
        l.love,
        l.loveTitle,
        l.loveBody,
        OrbitStyle.connection,
      ),
      PreviewFeature.wellness => (
        l.wellness,
        l.wellnessTitle,
        l.wellnessBody,
        OrbitStyle.calm,
      ),
    };
    return CelestialScaffold(
      children: [
        Text(label, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 28),
        const PreviewBadge(),
        const SizedBox(height: 20),
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 16),
        Text(body, style: Theme.of(context).textTheme.bodyLarge),
        Center(child: OrbitArt(style: style, size: 250)),
        DemoNotice(
          text: feature == PreviewFeature.astrology
              ? l.chartNotice
              : l.demoNotice,
        ),
        SectionHeader(l.foundation),
        SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.foundationBody),
              const SizedBox(height: 12),
              const LoadingSkeleton(),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SecondaryButton(
          label: l.backHome,
          onPressed: () => context.go('/home'),
        ),
      ],
    );
  }
}
