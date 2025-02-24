// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
class DefaultFirebaseOptions {
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAoGVZ87ITxIK7fJyS18KMzgDySYlmzb9s',
    appId: '1:667807371243:web:c9518d3e69d964661893ae',
    messagingSenderId: '667807371243',
    projectId: 'habit-tracker-90d5',
    authDomain: 'habit-tracker-90d5.firebaseapp.com',
    storageBucket: 'habit-tracker-90d5.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGLsj3iVbCJObp7vQHsNU2ftV9O6BqeSs',
    appId: '1:667807371243:android:d85dde03b0ec87391893ae',
    messagingSenderId: '667807371243',
    projectId: 'habit-tracker-90d5',
    storageBucket: 'habit-tracker-90d5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRLad6qp2zGotS_Mc-SPe5qKXSMk_vRHE',
    appId: '1:667807371243:ios:d9eed4693a76f41f1893ae',
    messagingSenderId: '667807371243',
    projectId: 'habit-tracker-90d5',
    storageBucket: 'habit-tracker-90d5.firebasestorage.app',
    iosBundleId: 'com.example.habitTracker',
  );
}
