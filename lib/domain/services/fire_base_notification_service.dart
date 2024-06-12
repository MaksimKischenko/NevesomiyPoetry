import 'dart:async';
import 'dart:developer';
// import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nevesomiy/domain/services/local_cache_service.dart';

class FireBaseNotificationService {
  FireBaseNotificationService._();
  static final _instance = FireBaseNotificationService._();
  static FireBaseNotificationService get instance => _instance;
  
  final _firebaseMessaging = FirebaseMessaging.instance;
  // final _firebaseInAppMessaging = FirebaseInAppMessaging.instance;
  final _cacheService = CacheService.instance;

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


  Future<void> enableFirebaseInAppMessaging() async {
    // await _firebaseInAppMessaging.triggerEvent('my_event');
  }

  Future<void> enableFirebaseMessaging() async {
    await Future.wait([
     _firebaseMessaging.getToken().then((token) {
      // Здесь вы можете отправить токен на ваш сервер, если это необходимо.
    }),
    _firebaseMessaging.subscribeToTopic('t3'),
    _cacheService.saveMessagesFlag(sendsMessages: true)
    ]);
  }

  Future<void> disableFirebaseMessaging() async {
    await Future.wait([
     _firebaseMessaging.unsubscribeFromTopic('t3'),
     _cacheService.saveMessagesFlag(sendsMessages: false)
    ]);
  }
}



