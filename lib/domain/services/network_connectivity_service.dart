import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityService {
  NetworkConnectivityService._();
  static final _instance = NetworkConnectivityService._();
  static NetworkConnectivityService get instance => _instance;
  
  Stream<bool> get myStream => _controller.stream;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();


  Future<void> initialise() async {
     final result = await _networkConnectivity.checkConnectivity();
     await _checkStatus(result.single);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result.single);
    });
  }

  Future<void> _checkStatus(ConnectivityResult result) async {
    var isOnline = false;
    try {
      if(result != ConnectivityResult.none) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add(isOnline);
  }

  void disposeStream() => _controller.close();
}