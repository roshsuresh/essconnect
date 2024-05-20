import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  late bool _isOnline = false;
  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        print('No internet');
        notifyListeners();
      } else {
        _isOnline = true;
        print('Internet true');
        notifyListeners();
      }
    });
  }
}
