import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/netvetta_api_constants.dart';
import '../models/customer_notification_model.dart';

class CustomerNotificationService {
  static Future<List<CustomerNotification>> getAll() async {
    try {
      final url = Uri.parse(NetvettaApiConstants.notificationUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;

        final notifications =
            jsonData.map((e) => CustomerNotification.fromJson(e)).toList();

        return notifications;
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
