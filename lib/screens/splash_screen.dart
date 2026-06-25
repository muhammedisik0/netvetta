import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/route_constants.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;

  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Image _appIcon;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorConstants.slateBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _appIcon,
          const SizedBox(
            width: 160,
            child: FittedBox(
              child: Text(
                'NETVETTA\nMAĞAZAM',
                style: TextStyle(
                  color: ColorConstants.goldenYellow,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _appIcon = Image.asset('assets/icons/app_icon.png', width: 240);

    Timer(Durations.extralong4, () {
      Navigator.pushReplacementNamed(context,
          widget.isLoggedIn ? RouteConstants.pages : RouteConstants.login);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(_appIcon.image, context);
    });
  }
}
