import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/prototype_models.dart';
import '../../core/widgets/stitch_layout.dart';

class UpcomingEventTile extends StatelessWidget {
  const UpcomingEventTile({super.key, required this.event, this.asset});
  final CosmicEvent event;
  final String? asset;
  @override
  Widget build(BuildContext context) => StitchCard(
    padding: 14,
    onTap: () => context.push('/calendar'),
    child: Row(
      children: [
        if (asset != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              asset!,
              width: 56,
              height: 64,
              fit: BoxFit.cover,
              excludeFromSemantics: true,
            ),
          )
        else
          const SizedBox(
            width: 56,
            height: 64,
            child: Icon(Icons.nights_stay_outlined),
          ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.title, style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 6),
              Text(
                event.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, size: 18),
      ],
    ),
  );
}
