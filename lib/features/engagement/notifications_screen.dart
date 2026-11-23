import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import 'data/notification_repository.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});
  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<NotificationsScreen> {
  int filter = 0;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final read = ref.watch(
      prototypeProvider.select((s) => s.readNotifications),
    );
    final notifications = ref
        .watch(notificationRepositoryProvider)
        .notifications(l);

    final ids = [0, 1, 2]
        .where(
          (i) =>
              filter == 0 ||
              (filter == 1 ? !read.contains(i) : read.contains(i)),
        )
        .toList();
    return PageFrame(
      title: l.notifications,
      children: [
        DemoNotice(text: l.notificationDemo),
        const SizedBox(height: 20),
        FilterStrip(
          labels: [l.all, l.unread, l.read],
          selected: filter,
          onSelected: (i) => setState(() => filter = i),
        ),
        TextButton(
          onPressed: () => ref.read(prototypeProvider.notifier).markAllRead(),
          child: Text(l.markAllRead),
        ),
        if (ids.isEmpty)
          EmptyState(title: l.notificationEmpty, body: l.notificationEmptyBody),
        for (final i in ids)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: StitchCard(
              padding: 0,
              child: MenuRow(
                icon: read.contains(i)
                    ? Icons.notifications_none
                    : Icons.notifications_active_outlined,
                title: notifications[i].title,
                subtitle: notifications[i].body,
                trailing: Icon(
                  Icons.circle,
                  size: 8,
                  color: read.contains(i)
                      ? AppColors.muted
                      : AppColors.lavender,
                ),
                onTap: () {
                  ref.read(prototypeProvider.notifier).markRead(i);
                  context.push(notifications[i].route);
                },
              ),
            ),
          ),
      ],
    );
  }
}
