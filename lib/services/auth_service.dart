import 'dart:async';

import 'package:http/http.dart' as http;

import '../constants/enum_constants.dart';
import '../constants/netvetta_api_constants.dart';
import '../models/user_model.dart';

class AuthService {
  static Future<LoginStatus> logIn(User user) async {
    try {
      final url = Uri.parse(NetvettaApiConstants.loginUrl);

      final response = await http
          .post(url, body: user.toApiJson())
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return response.body == 'error'
            ? LoginStatus.error
            : LoginStatus.success;
      }

      return LoginStatus.failure;
    } catch (e) {
      return LoginStatus.failure;
    }
  }
}
