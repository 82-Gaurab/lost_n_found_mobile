import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract interface class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo({required Connectivity connectivity})
    : _connectivity = connectivity;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity
        .checkConnectivity(); // info: checks for wifi or mobile data

    if (result.contains(ConnectivityResult.none)) {
      return false;
    }

    return await _checkIfInternetIsAvailable();
  }

  Future<bool> _checkIfInternetIsAvailable() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
