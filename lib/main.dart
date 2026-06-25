import 'package:flutter/material.dart';
import 'package:get_secure_storage/get_secure_storage.dart';

import 'constants/route_constants.dart';
import 'screens/login_screen.dart';
import 'screens/pages_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/splash_screen.dart';
import 'services/storage_service.dart';
import 'services/workmanager_service.dart';
import 'utils/globals.dart';

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
      navigatorKey: navigatorKey,
      initialRoute: RouteConstants.initialRoute,
      routes: {
        RouteConstants.initialRoute: (context) =>
            SplashScreen(isLoggedIn: StorageService.isLoggedIn),
        RouteConstants.login: (context) => LoginScreen(),
        RouteConstants.signUp: (context) => const SignUpScreen(),
        RouteConstants.pages: (context) => const PagesScreen(),
      },
    );
  }
}
