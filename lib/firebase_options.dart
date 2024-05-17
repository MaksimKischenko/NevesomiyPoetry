
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
mixin DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAccVhl2jVLZLj6f59NXIbMeaFLaarflYc',
    appId: '1:847524385890:web:8d9a9a13dab2759ceead3b',
    messagingSenderId: '847524385890',
    projectId: 'nevesomiy-b6c49',
    authDomain: 'nevesomiy-b6c49.firebaseapp.com',
    storageBucket: 'nevesomiy-b6c49.appspot.com',
    measurementId: 'G-TN0B3DEVZD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHluYZBreuTgmX7q4RJQ_oZFemyKFw7w0',
    appId: '1:847524385890:android:a6e43f578a6a3af9eead3b',
    messagingSenderId: '847524385890',
    projectId: 'nevesomiy-b6c49',
    storageBucket: 'nevesomiy-b6c49.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvApHFEo6-hM0wKGxhwxtf_fTOcyQn398',
    appId: '1:847524385890:ios:3061777734a0a9c5eead3b',
    messagingSenderId: '847524385890',
    projectId: 'nevesomiy-b6c49',
    storageBucket: 'nevesomiy-b6c49.appspot.com',
    iosBundleId: 'com.prdoduction.nevesomiy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvApHFEo6-hM0wKGxhwxtf_fTOcyQn398',
    appId: '1:847524385890:ios:fb5ea7033f96db22eead3b',
    messagingSenderId: '847524385890',
    projectId: 'nevesomiy-b6c49',
    storageBucket: 'nevesomiy-b6c49.appspot.com',
    iosBundleId: 'com.prdoduction.nevesomiy.RunnerTests',
  );
}
