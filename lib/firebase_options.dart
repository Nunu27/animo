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
    apiKey: 'AIzaSyBwNTKvnwAhy1smBhwA4WUXDmVB1xmrgGg',
    appId: '1:951278545502:web:505bfa5daa1599eecaa2cf',
    messagingSenderId: '951278545502',
    projectId: 'animo-firebase',
    authDomain: 'animo-firebase.firebaseapp.com',
    storageBucket: 'animo-firebase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPIbxonmD5AMUJ6-iFB5XBCGnUh8SwD8g',
    appId: '1:951278545502:android:98eccca0dfdf3d2fcaa2cf',
    messagingSenderId: '951278545502',
    projectId: 'animo-firebase',
    storageBucket: 'animo-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP-p4uYzdy4mfCq0Wraq5MI93M2YSXYGM',
    appId: '1:951278545502:ios:620325b0f89a2664caa2cf',
    messagingSenderId: '951278545502',
    projectId: 'animo-firebase',
    storageBucket: 'animo-firebase.appspot.com',
    androidClientId: '951278545502-es15tmtt8egqv57qft6akkph8p1jq7g4.apps.googleusercontent.com',
    iosBundleId: 'com.panu.animo',
  );
}
