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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCTf7J8ySFdFubjoCoQM2nvGf7Lg50VZgc',
    appId: '1:5567214762:web:0bbd9ff2cea69d284c0cd3',
    messagingSenderId: '5567214762',
    projectId: 'app-mov2',
    authDomain: 'app-mov2.firebaseapp.com',
    databaseURL: 'https://app-mov2-default-rtdb.firebaseio.com',
    storageBucket: 'app-mov2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiLX9-4F5vA55PyG54BWCE947z1ZinSWA',
    appId: '1:5567214762:android:d444225a0a8983794c0cd3',
    messagingSenderId: '5567214762',
    projectId: 'app-mov2',
    databaseURL: 'https://app-mov2-default-rtdb.firebaseio.com',
    storageBucket: 'app-mov2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvJq1CbFfZgmoKLLco7O4BGKrI61wcV0k',
    appId: '1:5567214762:ios:2494f7d65c2bab024c0cd3',
    messagingSenderId: '5567214762',
    projectId: 'app-mov2',
    databaseURL: 'https://app-mov2-default-rtdb.firebaseio.com',
    storageBucket: 'app-mov2.appspot.com',
    iosBundleId: 'com.example.proyectoFinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvJq1CbFfZgmoKLLco7O4BGKrI61wcV0k',
    appId: '1:5567214762:ios:2494f7d65c2bab024c0cd3',
    messagingSenderId: '5567214762',
    projectId: 'app-mov2',
    databaseURL: 'https://app-mov2-default-rtdb.firebaseio.com',
    storageBucket: 'app-mov2.appspot.com',
    iosBundleId: 'com.example.proyectoFinal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCTf7J8ySFdFubjoCoQM2nvGf7Lg50VZgc',
    appId: '1:5567214762:web:55f06827b8de37b64c0cd3',
    messagingSenderId: '5567214762',
    projectId: 'app-mov2',
    authDomain: 'app-mov2.firebaseapp.com',
    databaseURL: 'https://app-mov2-default-rtdb.firebaseio.com',
    storageBucket: 'app-mov2.appspot.com',
  );

}