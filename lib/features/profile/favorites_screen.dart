import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key, this.type});
  final String? type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l;
    final items = ref
        .watch(prototypeProvider)
        .saved
        .where((id) => type == null || id.startsWith(type!))
        .toList();
    return PageFrame(
      title: l.favorites,
      children: [
        if (items.isEmpty)
          EmptyState(title: l.noFavorites, body: l.noFavoritesBody),
        for (final id in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StitchCard(
              padding: 0,
              child: MenuRow(
                icon: Icons.bookmark,
                title: id.startsWith('feature-') ? _featureTitle(context,id.substring(8)) : id.startsWith('meditation')
                    ? l.meditate
                    : id.startsWith('event')
                    ? l.cosmicCalendar
                    : id.startsWith('numerology')
                    ? l.numerology
                    : id.startsWith('compatibility')
                    ? l.compatibility
                    : id.startsWith('insight')
                    ? l.insight
                    : l.horoscope,
                subtitle: _subtitle(context,id),
                onTap: () => context.push(_route(id)),
                trailing: IconButton(
                  tooltip: l.delete,
                  onPressed: () =>
                      ref.read(prototypeProvider.notifier).toggleSaved(id),
                  icon: const Icon(Icons.bookmark_remove_outlined),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _route(String id) {
    final parts=id.split('-');
    if (id.startsWith('feature-')) return id.substring(8);
    if (id.startsWith('meditation-')) return '/meditation/${id.substring(11)}';
    if (id.startsWith('event-')&&parts.length>=4) return '/calendar?month=${parts[parts.length-2]}-${parts.last.padLeft(2,'0')}-01';
    if (id.startsWith('numerology')) return '/numerology-report';
    if (id.startsWith('compatibility')) return '/compatibility-report';
    if (id.startsWith('insight')&&parts.length>=3) return '/insight?kind=${parts[1]}&index=${parts[2]}';
    if(parts.length>=6)return '/horoscope?sign=${parts[1]}&period=${parts[2]}&date=${parts[3]}-${parts[4].padLeft(2,'0')}-${parts[5].padLeft(2,'0')}';
    return '/horoscope';
  }

  String _subtitle(BuildContext c,String id){
    final parts=id.split('-');
    if(id.startsWith('horoscope-')&&parts.length>=6){
      final date=DateTime(int.parse(parts[3]),int.parse(parts[4]),int.parse(parts[5]));
      final period=int.parse(parts[2]).clamp(0,2);
      return '${[c.l.daily,c.l.weekly,c.l.monthly][period]} · ${DateFormat.yMMMd(c.l.localeName).format(date)} · ${c.l.preview}';
    }
    return c.l.preview;
  }

  String _featureTitle(BuildContext c,String route)=>switch(route){
    '/birth-chart'=>c.l.birthChart,'/zodiac'=>c.l.zodiacExplore,'/numerology'=>c.l.numerology,
    '/calendar'=>c.l.cosmicCalendar,'/partner-details'=>c.l.compatibility,'/meditations'=>c.l.meditationLibrary,
    '/breathing'=>c.l.breathing,'/journal'=>c.l.journal,'/community'=>c.l.community,
    '/premium'=>c.l.plus,'/achievements'=>c.l.achievements,_=>c.l.horoscope,
  };
}
