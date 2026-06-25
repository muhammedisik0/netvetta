import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._private();

  final _plugin = FlutterLocalNotificationsPlugin();

  factory LocalNotificationService() => _instance;

  LocalNotificationService._private();

  Future<void> initialize() async {
    final androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettings =
        InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings: initializationSettings);
  }

  Future<void> show(
      {int id = 0, String? title, String? body, String? payload}) {
    return _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'app_notifications',
          'App Notifications',
          importance: Importance.max,
        ),
      ),
    );
  }
}
