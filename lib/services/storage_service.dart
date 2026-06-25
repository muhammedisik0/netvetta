import 'package:get_secure_storage/get_secure_storage.dart';

class StorageService {
  static final _storage = GetSecureStorage();

  static String get phoneNumber => _storage.read('phoneNumber') ?? '';

  static Future<void> setPhoneNumber(String value) async =>
      await _storage.write('phoneNumber', value);

  static String get password => _storage.read('password') ?? '';

  static Future<void> setUserCode(String value) async =>
      await _storage.write('userCode', value);

  static String get userCode => _storage.read('userCode') ?? '';

  static Future<void> setPassword(String value) async =>
      await _storage.write('password', value);

  static bool get isLoggedIn => _storage.read('isLoggedIn') ?? false;

  static Future<void> setIsLoggedIn(bool value) async =>
      await _storage.write('isLoggedIn', value);

  static int get userId => _storage.read('userId') ?? -1;

  static set userId(int value) => _storage.write('userId', value);

  static String get lastNotificationId =>
      _storage.read('lastNotificationId') ?? '0';

  static set lastNotificationId(String value) =>
      _storage.write('lastNotificationId', value);
}
