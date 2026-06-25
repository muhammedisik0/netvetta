class NetvettaApiConstants {
  NetvettaApiConstants._();

  static const String _baseUrl = 'https://netvetta.net';

  static const String _loginEndpoint = '/login/do_login_app';

  static const String _logoutEndpoint = '/login/logout';

  static const String notificationsEndpoint =
      '/panel/index.php/test/test_bildirim_json';

  static const String loginUrl = _baseUrl + _loginEndpoint;

  static const String logoutUrl = _baseUrl + _logoutEndpoint;

  static const String notificationUrl = _baseUrl + notificationsEndpoint;
}
