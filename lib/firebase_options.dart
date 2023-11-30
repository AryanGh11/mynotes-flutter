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
    apiKey: 'AIzaSyB0nekxFOpoGVo-HOkCor_BGI0ky82ZB-c',
    appId: '1:843857777864:web:8b60c08dfc8c9ed19541fd',
    messagingSenderId: '843857777864',
    projectId: 'mynote-devby-aryan',
    authDomain: 'mynote-devby-aryan.firebaseapp.com',
    storageBucket: 'mynote-devby-aryan.appspot.com',
    measurementId: 'G-ZF0YPVGJN5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQUsLlh9MvdIzRd_WT8y_AUcUPFYfb6qc',
    appId: '1:843857777864:android:0fc936b520dcebfe9541fd',
    messagingSenderId: '843857777864',
    projectId: 'mynote-devby-aryan',
    storageBucket: 'mynote-devby-aryan.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAedY_4EQCLVj0bo_gF_MBWFxUgSaCVLaE',
    appId: '1:843857777864:ios:b07645a97a5b1c849541fd',
    messagingSenderId: '843857777864',
    projectId: 'mynote-devby-aryan',
    storageBucket: 'mynote-devby-aryan.appspot.com',
    iosBundleId: 'com.aryan.mynotes.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAedY_4EQCLVj0bo_gF_MBWFxUgSaCVLaE',
    appId: '1:843857777864:ios:5d8328b9714a8d459541fd',
    messagingSenderId: '843857777864',
    projectId: 'mynote-devby-aryan',
    storageBucket: 'mynote-devby-aryan.appspot.com',
    iosBundleId: 'com.aryan.mynotes.mynotes.RunnerTests',
  );
}