import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/orbit_art.dart';
import '../../l10n/app_localizations.dart';

class AstrologyHeroCard extends StatelessWidget {
  const AstrologyHeroCard({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF33245E), AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.lavender.withValues(alpha: .3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                DateFormat.yMMMMEEEEd(l.localeName).format(DateTime.now()),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const PreviewBadge(),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final title = Text(
                l.outlook,
                style: Theme.of(context).textTheme.displaySmall,
              );
              return constraints.maxWidth > 420
                  ? Row(
                      children: [
                        Expanded(child: title),
                        const OrbitArt(size: 150),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        const Align(
                          alignment: Alignment.centerRight,
                          child: OrbitArt(size: 140),
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 12),
          Text(l.virgo, style: const TextStyle(color: AppColors.gold)),
          Text(l.sampleProfile, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          Text(l.outlookBody),
          const SizedBox(height: 24),
          PrimaryButton(label: l.viewPreview, onPressed: onPressed),
        ],
      ),
    );
  }
}
