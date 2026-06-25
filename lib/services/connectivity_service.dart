import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<List<ConnectivityResult>> get connectivityResult async {
    return await _connectivity.checkConnectivity();
  }

  bool hasInternet(List<ConnectivityResult> results) {
    return results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.mobile);
  }
}
