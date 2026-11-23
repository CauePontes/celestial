import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/orbital_crest.dart';
import '../../core/widgets/stitch_layout.dart';

class AstrologyHeroCard extends StatelessWidget {
  const AstrologyHeroCard({super.key});
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return StitchCard(
      child: Stack(
        children: [
          const Positioned(
            right: -70,
            top: -90,
            child: OrbitalCrest(size: 190),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Kicker(
                '${DateFormat.MMMMd(l.localeName).format(DateTime.now())} · ${l.daily}',
              ),
              const SizedBox(height: 12),
              Text(
                l.todayAlignment,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(l.alignmentBody),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => context.push('/horoscope'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.gold,
                  padding: EdgeInsets.zero,
                ),
                child: Text('${l.readFull} →'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
