import 'package:workmanager/workmanager.dart';

import 'background_task_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    return await BackgroundTaskService.showCustomerNotifications();
  });
}

class WorkmanagerService {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);

    await Workmanager().cancelAll();

    await Workmanager().registerPeriodicTask(
      'customer_notification_task',
      'show_customer_notifications',
      frequency: const Duration(minutes: 15),
    );
  }
}
