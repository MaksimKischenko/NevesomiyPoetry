import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseNotificationService {
  FireBaseNotificationService._();
  static final _instance = FireBaseNotificationService._();
  static FireBaseNotificationService get instance => _instance;
  
  final _firebaseMessaging = FirebaseMessaging.instance;
  Stream<RemoteMessage> get myInAppStream => FirebaseMessaging.onMessage;
  Stream<RemoteMessage> get myOutAppStream => FirebaseMessaging.onMessageOpenedApp;

  Future<void> getToken() async {
    await _firebaseMessaging.getToken().then((token) {
      log('Firebase Token: $token');
    });
  }

  Future<void> editMessagePermissions() async {
    
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );     
  }
}

    // _firebaseMessaging
    //     .subscribeToTopic('t3')
    //     .then((value) => log('topic subscrition finished'));