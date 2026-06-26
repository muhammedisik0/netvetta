import 'package:get_secure_storage/get_secure_storage.dart';

import 'storage_service.dart';
import 'customer_notification_service.dart';
import 'local_notification_service.dart';

class BackgroundTaskService {
  static Future<bool> showCustomerNotifications() async {
    try {
      await GetSecureStorage.init();
      await LocalNotificationService().initialize();

      final notifications = await CustomerNotificationService.getAll();

      if (notifications.isNotEmpty) {
        final lastNotificationId = int.parse(StorageService.lastNotificationId);

        final firstNotification = notifications.first;

        final difference = int.parse(firstNotification.id) - lastNotificationId;

        final count = difference.clamp(0, notifications.length);

        final latestNotifications = notifications.take(count > 10 ? 10 : count);

        final user = StorageService.user;

        for (final notification in latestNotifications) {
          final cari = int.parse(notification.cari);

          if (cari == user?.id || cari == 0) {
            LocalNotificationService().show(
              id: int.parse(notification.id),
              title: 'Netvetta',
              body: notification.content,
            );
          }
        }

        StorageService.lastNotificationId = firstNotification.id;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
