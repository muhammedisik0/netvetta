import 'package:flutter/material.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

import 'constants/netvetta_web_constants.dart';
import 'constants/route_constants.dart';
import 'screens/login_screen.dart';
import 'screens/pages_screen.dart';
import 'screens/signup_webview_screen.dart';
import 'screens/splash_screen.dart';
import 'services/storage_service.dart';
import 'services/workmanager_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetSecureStorage.init();
  await WorkmanagerService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.initialRoute,
      routes: {
        RouteConstants.initialRoute: (context) =>
            SplashScreen(isLoggedIn: StorageService.user != null),
        RouteConstants.login: (context) => LoginScreen(),
        RouteConstants.signUp: (context) =>
            SignupWebViewScreen(url: Uri.parse(NetvettaWebConstants.signup)),
        RouteConstants.pages: (context) => const PagesScreen(),
      },
    );
  }
}
