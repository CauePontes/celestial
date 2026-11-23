import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../utils/context_extensions.dart';

class ZodiacBadge extends StatelessWidget {
  const ZodiacBadge({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.wb_twilight, color: AppColors.gold, size: 18),
      const SizedBox(width: 8),
      Flexible(
        child: Text(label, style: Theme.of(context).textTheme.bodySmall),
      ),
    ],
  );
}

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key, this.label});
  final String? label;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.gold.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Text(
      (label ?? context.l.plus).toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: AppColors.gold,
        letterSpacing: .6,
      ),
    ),
  );
}
