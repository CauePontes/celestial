import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../utils/context_extensions.dart';
import 'components.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({
    super.key,
    required this.title,
    required this.children,
    this.back = true,
    this.actions,
    this.onBack,
    this.maxWidth = 720,
  });
  final String title;
  final List<Widget> children;
  final bool back;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final double maxWidth;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CosmicBackground(
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth + 40),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      if (back)
                        IconButton(
                          tooltip: context.l.back,
                          onPressed:
                              onBack ??
                              () => context.canPop()
                                  ? context.pop()
                                  : context.go('/home'),
                          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        ),
                      if (!back) const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      ...?actions,
                      if (actions == null) ...[
                        if (!back)
                          IconButton(
                            tooltip: context.l.notifications,
                            onPressed: () => context.push('/notifications'),
                            icon: const Icon(Icons.notifications_none_outlined),
                          ),
                        IconButton(
                          tooltip: context.l.profile,
                          onPressed: () => context.go('/profile'),
                          icon: const CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.lavender,
                            child: Icon(
                              Icons.person_outline,
                              size: 20,
                              color: AppColors.background,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                key: PageStorageKey(title),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
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
    ),
  );
}

class StitchCard extends StatelessWidget {
  const StitchCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = 20,
    this.elevated = false,
    this.gradient = false,
  });
  final Widget child;
  final VoidCallback? onTap;
  final double padding;
  final bool elevated, gradient;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: gradient
          ? const LinearGradient(
              colors: [Color(0xFF33245E), AppColors.surface],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            )
          : null,
    ),
    child: Material(
      color: gradient
          ? Colors.transparent
          : (elevated
                ? Theme.of(context).colorScheme.surfaceContainerHigh
                : Theme.of(context).colorScheme.surface),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: EdgeInsets.all(padding), child: child),
      ),
    ),
  );
}

class Kicker extends StatelessWidget {
  const Kicker(this.text, {super.key, this.gold = true});
  final String text;
  final bool gold;
  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: Theme.of(context).textTheme.labelSmall?.copyWith(
      color: gold ? AppColors.gold : AppColors.lavender,
      letterSpacing: 1.2,
      height: 1.5,
    ),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.action, this.onAction});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 12),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 4,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (action != null && onAction != null)
          TextButton(onPressed: onAction, child: Text(action!)),
        if (action != null && onAction == null)
          Text(action!, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}

class MenuRow extends StatelessWidget {
  const MenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.gold = false,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool gold;
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    leading: CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.surfaceElevated,
      child: Icon(
        icon,
        size: 19,
        color: gold ? AppColors.gold : AppColors.lavender,
      ),
    ),
    title: Text(title, style: Theme.of(context).textTheme.titleSmall),
    subtitle: subtitle == null
        ? null
        : Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
    trailing:
        trailing ??
        (onTap == null ? null : const Icon(Icons.chevron_right, size: 20)),
    onTap: onTap,
  );
}

class AdaptiveGrid extends StatelessWidget {
  const AdaptiveGrid({super.key, required this.children, this.columns = 2});
  final List<Widget> children;
  final int columns;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final count =
          c.maxWidth < 300 || MediaQuery.textScalerOf(context).scale(16) > 25
          ? 1
          : columns;
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final child in children)
            SizedBox(
              width: (c.maxWidth - (count - 1) * 12) / count,
              child: child,
            ),
        ],
      );
    },
  );
}

class FilterStrip extends StatelessWidget {
  const FilterStrip({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });
  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                labels[i],
                style: const TextStyle(
                  fontFamilyFallback: ['Noto Symbols', 'Noto Symbols2'],
                ),
              ),
              selected: selected == i,
              onSelected: (_) => onSelected(i),
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.surface,
              labelStyle: TextStyle(
                color: selected == i
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
              side: BorderSide.none,
              shape: const StadiumBorder(),
              showCheckmark: false,
            ),
          ),
      ],
    ),
  );
}

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    super.key,
    required this.asset,
    required this.title,
    required this.subtitle,
    this.tag,
    this.onTap,
    this.height = 170,
  });
  final String asset, title, subtitle;
  final String? tag;
  final VoidCallback? onTap;
  final double height;
  @override
  Widget build(BuildContext context) => StitchCard(
    padding: 0,
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              asset,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              excludeFromSemantics: true,
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.surface.withValues(alpha: .96),
                    ],
                  ),
                ),
              ),
            ),
            if (tag != null)
              Positioned(
                left: 16,
                top: 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      color: AppColors.background.withValues(alpha: .8),
                      child: Text(
                        tag!,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              if (onTap != null)
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: AppColors.lavender,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });
  final String value, label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => StitchCard(
    padding: 14,
    child: Column(
      children: [
        Icon(icon, color: AppColors.lavender, size: 20),
        const SizedBox(height: 12),
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}

void showMessage(BuildContext context, String message) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(message)));
