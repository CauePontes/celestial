import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../app/theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = [
      (Icons.home_outlined, l.home),
      (Icons.auto_awesome_outlined, l.astrology),
      (Icons.favorite_border, l.love),
      (Icons.self_improvement, l.wellness),
      (Icons.person_outline, l.profile),
    ];
    return NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: Icon(item.$1, color: AppColors.textSecondary),
            selectedIcon: Icon(item.$1, color: AppColors.lavender),
            label: item.$2,
          ),
      ],
    );
  }
}
