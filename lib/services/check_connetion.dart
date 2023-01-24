import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnection {
  static Future<bool> checkInternetConnection() async {
    var checkConnectivity = await Connectivity().checkConnectivity();
    if (checkConnectivity == ConnectivityResult.mobile ||
        checkConnectivity == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
