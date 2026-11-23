import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = [
      (Icons.home_outlined, l.home),
      (Icons.blur_circular_outlined, l.astrology),
      (Icons.favorite_border, l.love),
      (Icons.spa_outlined, l.wellness),
      (Icons.account_circle_outlined, l.profile),
    ];
    return NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
      destinations: [
        for (final item in items)
          NavigationDestination(icon: Icon(item.$1), label: item.$2),
      ],
    );
  }
}
