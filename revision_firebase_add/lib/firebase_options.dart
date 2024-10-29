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
    apiKey: 'AIzaSyCr_qWrS92g4WQ9tRunV8FRbybER8g4VSI',
    appId: '1:861568117409:web:8bb848296c174c9ac4dee0',
    messagingSenderId: '861568117409',
    projectId: 'db2107b1',
    authDomain: 'db2107b1.firebaseapp.com',
    storageBucket: 'db2107b1.appspot.com',
    measurementId: 'G-P2YKE6TNMC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-pKxaRt9VmP9wg_m-lVPBiNeXt9CtfmE',
    appId: '1:861568117409:android:5aeb14b6d54deb07c4dee0',
    messagingSenderId: '861568117409',
    projectId: 'db2107b1',
    storageBucket: 'db2107b1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRmj5yJCcyw9QbffDZA3MGAfhx32Hgc-o',
    appId: '1:861568117409:ios:01a6ec63a77dc161c4dee0',
    messagingSenderId: '861568117409',
    projectId: 'db2107b1',
    storageBucket: 'db2107b1.appspot.com',
    iosBundleId: 'com.example.revisionFirebaseAdd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRmj5yJCcyw9QbffDZA3MGAfhx32Hgc-o',
    appId: '1:861568117409:ios:01a6ec63a77dc161c4dee0',
    messagingSenderId: '861568117409',
    projectId: 'db2107b1',
    storageBucket: 'db2107b1.appspot.com',
    iosBundleId: 'com.example.revisionFirebaseAdd',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCr_qWrS92g4WQ9tRunV8FRbybER8g4VSI',
    appId: '1:861568117409:web:59a3d7cce8c83a5bc4dee0',
    messagingSenderId: '861568117409',
    projectId: 'db2107b1',
    authDomain: 'db2107b1.firebaseapp.com',
    storageBucket: 'db2107b1.appspot.com',
    measurementId: 'G-MTMCCFPKX2',
  );
}
