import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../services/connectivity_service.dart';
import '../utils/globals.dart';
import 'no_internet_connection_widget.dart';

class InternetConnectivityWidget extends StatefulWidget {
  final Widget online;

  const InternetConnectivityWidget({super.key, required this.online});

  @override
  State<InternetConnectivityWidget> createState() =>
      _InternetConnectivityWidgetState();
}

class _InternetConnectivityWidgetState
    extends State<InternetConnectivityWidget> {
  final _connectivityService = ConnectivityService();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _hasInternetConnection = true;

  @override
  Widget build(BuildContext context) {
    return _hasInternetConnection
        ? widget.online
        : const NoInternetConnectionWidget();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkInitialInternetConnection();

    _connectivitySubscription =
        _connectivityService.connectivityStream.listen((result) {
      final hasInternetConnection = _connectivityService.hasInternet(result);
      setState(() => _hasInternetConnection = hasInternetConnection);
      internetNotifier.value = hasInternetConnection;
    });
  }

  void _checkInitialInternetConnection() async {
    final result = await _connectivityService.connectivityResult;
    final hasInternetConnection = _connectivityService.hasInternet(result);
    setState(() => _hasInternetConnection = hasInternetConnection);
  }
}
