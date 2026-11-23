import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../models/prototype_models.dart';

abstract interface class CatalogRepository {
  Future<PrototypeCatalog> load(String locale);
  List<CosmicEvent> events(AppLocalizations l, DateTime month);
}

class MockCatalogRepository implements CatalogRepository {
  const MockCatalogRepository();
  @override
  Future<PrototypeCatalog> load(String locale) async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    final l = lookupAppLocalizations(Locale(locale.split('_').first));
    final names = [
      l.aries,
      l.taurus,
      l.gemini,
      l.cancer,
      l.leo,
      l.virgoName,
      l.libra,
      l.scorpio,
      l.sagittarius,
      l.capricorn,
      l.aquarius,
      l.pisces,
    ];
    const glyphs = ['♈', '♉', '♊', '♋', '♌', '♍', '♎', '♏', '♐', '♑', '♒', '♓'];
    final elements = [l.fire, l.earth, l.air, l.water];
    final modes = [l.cardinal, l.fixed, l.mutable];
    const starts = [
      (3, 21),
      (4, 20),
      (5, 21),
      (6, 21),
      (7, 23),
      (8, 23),
      (9, 23),
      (10, 23),
      (11, 22),
      (12, 22),
      (1, 20),
      (2, 19),
    ];
    const ends = [
      (4, 19),
      (5, 20),
      (6, 20),
      (7, 22),
      (8, 22),
      (9, 22),
      (10, 22),
      (11, 21),
      (12, 21),
      (1, 19),
      (2, 18),
      (3, 20),
    ];
    final bodies = [
      l.communityPostOne,
      l.communityPostTwo,
      l.communityPostThree,
      l.communityPostFour,
      l.communityPostFive,
      l.communityPostSix,
      l.communityPostSeven,
      l.communityPostEight,
    ];
    return PrototypeCatalog(
      signs: [
        for (var i = 0; i < 12; i++)
          ZodiacSign(
            i,
            names[i],
            glyphs[i],
            elements[i % 4],
            modes[i % 3],
            DateTime(2000, starts[i].$1, starts[i].$2),
            DateTime(2000, ends[i].$1, ends[i].$2),
          ),
      ],
      meditations: [
        Meditation(
          'moonrise',
          l.moonriseMeditation,
          l.calm,
          12,
          l.meditationBody,
          'assets/stitch/8__wellness_hub_1.jpg',
        ),
        Meditation(
          'dawn',
          l.dawnMeditation,
          l.focus,
          8,
          l.meditationBody,
          'assets/stitch/12__natal_chart_deep_dive_1.jpg',
        ),
        Meditation(
          'landing',
          l.sleepMeditation,
          l.sleep,
          15,
          l.meditationBody,
          'assets/stitch/8__wellness_hub_1.jpg',
        ),
        Meditation(
          'center',
          l.focusMeditation,
          l.focus,
          6,
          l.meditationBody,
          'assets/stitch/7__love_hub_2.jpg',
        ),
        Meditation(
          'room',
          l.calmMeditation,
          l.calm,
          10,
          l.meditationBody,
          'assets/stitch/12__natal_chart_deep_dive_2.jpg',
        ),
        Meditation(
          'sky',
          l.nightMeditation,
          l.sleep,
          18,
          l.meditationBody,
          'assets/stitch/11__celestial_plus_subscription_1.jpg',
        ),
      ],
      posts: [
        for (var i = 0; i < 8; i++)
          CommunityPost(
            id: 'sample-$i',
            author: const [
              'Elena',
              'Jordan',
              'Alex',
              'Sam',
              'Riley',
              'Morgan',
              'Taylor',
              'Casey',
            ][i],
            body: bodies[i],
            category: i % 3,
          ),
      ],
    );
  }

  @override
  List<CosmicEvent> events(AppLocalizations l, DateTime month) => [
    CosmicEvent(
      'moon-${month.year}-${month.month}',
      l.newMoonScorpio,
      l.newMoonBody,
      l.lunarPhase,
      DateTime(month.year, month.month, 1, 12, 47),
      EventCategory.moon,
    ),
    CosmicEvent(
      'mars-${month.year}-${month.month}',
      l.marsLeo,
      l.marsBody,
      l.planetaryShift,
      DateTime(month.year, month.month, 4, 4, 18),
      EventCategory.transit,
    ),
    CosmicEvent(
      'venus-${month.year}-${month.month}',
      l.venusCapricorn,
      l.venusEventBody,
      l.relationships,
      DateTime(month.year, month.month, 11, 18, 25),
      EventCategory.personal,
    ),
    CosmicEvent(
      'full-${month.year}-${month.month}',
      l.fullMoonTaurus,
      l.fullMoonBody,
      l.supermoon,
      DateTime(month.year, month.month, 15, 21, 28),
      EventCategory.moon,
    ),
    CosmicEvent(
      'pluto-${month.year}-${month.month}',
      l.plutoAquarius,
      l.plutoBody,
      l.majorEra,
      DateTime(month.year, month.month, 19, 20, 29),
      EventCategory.transit,
    ),
  ];
}

final catalogRepositoryProvider = Provider<CatalogRepository>(
  (ref) => const MockCatalogRepository(),
);
final catalogProvider = FutureProvider.family<PrototypeCatalog, String>(
  (ref, locale) => ref.watch(catalogRepositoryProvider).load(locale),
);
