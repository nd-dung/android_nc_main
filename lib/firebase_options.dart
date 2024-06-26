// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDdSZdYyjO3sHJWQvNuxULGdHPT48lbnDw',
    appId: '1:1050477868620:web:a1f7ae7412ecfc0d18a6e9',
    messagingSenderId: '1050477868620',
    projectId: 'english-learning-c2b25',
    authDomain: 'english-learning-c2b25.firebaseapp.com',
    storageBucket: 'english-learning-c2b25.appspot.com',
    measurementId: 'G-WRXDZ4YDBM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4nXres3EjWRH14byRhffcEb0Qh4v9gCg',
    appId: '1:1050477868620:android:f0a71a27f19fbe4f18a6e9',
    messagingSenderId: '1050477868620',
    projectId: 'english-learning-c2b25',
    storageBucket: 'english-learning-c2b25.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvnOwg9ABe3mB40i36f9Rf0LX4IcmcJJg',
    appId: '1:1050477868620:ios:d65bc43337a44a7e18a6e9',
    messagingSenderId: '1050477868620',
    projectId: 'english-learning-c2b25',
    storageBucket: 'english-learning-c2b25.appspot.com',
    iosClientId: '1050477868620-eupfrhr3k4td3u202j4plqrlot38n7lo.apps.googleusercontent.com',
    iosBundleId: 'com.example.englishLearning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvnOwg9ABe3mB40i36f9Rf0LX4IcmcJJg',
    appId: '1:1050477868620:ios:8e76b5d572a0b1cc18a6e9',
    messagingSenderId: '1050477868620',
    projectId: 'english-learning-c2b25',
    storageBucket: 'english-learning-c2b25.appspot.com',
    iosClientId: '1050477868620-7ul7j90p5ht7bd08du1aqfuke8fhrbtq.apps.googleusercontent.com',
    iosBundleId: 'com.example.englishLearning.RunnerTests',
  );
}
