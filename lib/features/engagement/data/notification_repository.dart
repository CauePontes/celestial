import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';

class DemoNotification {
  const DemoNotification(this.id, this.title, this.body, this.route);
  final int id;
  final String title, body, route;
}

abstract interface class NotificationRepository {
  List<DemoNotification> notifications(AppLocalizations l);
}

class MockNotificationRepository implements NotificationRepository {
  const MockNotificationRepository();
  @override
  List<DemoNotification> notifications(
    AppLocalizations l,
  ) => List.unmodifiable([
    DemoNotification(0, l.notificationOne, l.notificationBody, '/horoscope'),
    DemoNotification(1, l.notificationTwo, l.notificationBody, '/breathing'),
    DemoNotification(2, l.notificationThree, l.notificationBody, '/calendar'),
  ]);
}

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => const MockNotificationRepository(),
);
