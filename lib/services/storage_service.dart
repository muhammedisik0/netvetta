import 'dart:convert';

import 'package:get_secure_storage/get_secure_storage.dart';

import '../models/user_model.dart';

class StorageService {
  static final _storage = GetSecureStorage();

  static String get lastNotificationId =>
      _storage.read('lastNotificationId') ?? '0';

  static set lastNotificationId(String value) =>
      _storage.write('lastNotificationId', value);

  static User? get user {
    final data = _storage.read<String?>('user');
    return data != null ? User.fromJson(json.decode(data)) : null;
  }

  static set user(User? user) {
    final value = json.encode(user!.toJson());
    _storage.write('user', value);
  }
}
