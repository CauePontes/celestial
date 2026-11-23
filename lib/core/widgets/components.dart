import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class CosmicBackground extends StatelessWidget {
  const CosmicBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: AppColors.background,
      gradient: RadialGradient(
        center: Alignment.topRight,
        radius: 1,
        colors: [Color(0x225532A8), Color(0x00141126)],
      ),
    ),
    child: child,
  );
}

class CelestialScaffold extends StatelessWidget {
  const CelestialScaffold({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => CosmicBackground(
    child: SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({super.key, required this.child, this.padding = 20});
  final Widget child;
  final double padding;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: AppColors.border.withValues(alpha: .6)),
    ),
    child: child,
  );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 16),
    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
  );
}

class DemoNotice extends StatelessWidget {
  const DemoNotice({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 2),
        child: Icon(Icons.info_outline, size: 18, color: AppColors.lavender),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          text ?? AppLocalizations.of(context).demoNotice,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    ],
  );
}

class PreviewBadge extends StatelessWidget {
  const PreviewBadge({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppColors.lavender.withValues(alpha: .12),
    ),
    child: Text(
      AppLocalizations.of(context).preview,
      style: Theme.of(
        context,
      ).textTheme.labelMedium?.copyWith(color: AppColors.lavender),
    ),
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: FilledButton(
      onPressed: loading ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: loading
            ? Semantics(
                label: AppLocalizations.of(context).loading,
                child: const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : Text(label, textAlign: TextAlign.center),
      ),
    ),
  );
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) =>
      OutlinedButton(onPressed: onPressed, child: Text(label));
}

class FeatureTile extends StatelessWidget {
  const FeatureTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.subtitle,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: AppColors.border),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.lavender, size: 26),
            const SizedBox(height: 20),
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
            ],
          ],
        ),
      ),
    ),
  );
}

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => SurfaceCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const PreviewBadge(),
          ],
        ),
        const SizedBox(height: 16),
        Text(body),
      ],
    ),
  );
}

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key});
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Column(
      children: [
        for (final width in [1.0, .85, .55])
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FractionallySizedBox(
              widthFactor: width,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.border.withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => SurfaceCard(
    child: Column(
      children: [
        const Icon(Icons.nights_stay_outlined, color: AppColors.lavender),
        const SizedBox(height: 16),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(body, textAlign: TextAlign.center),
      ],
    ),
  );
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
  });
  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(labelText: label),
  );
}
