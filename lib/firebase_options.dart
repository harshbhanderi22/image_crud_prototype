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
    apiKey: 'AIzaSyD_HMRuAMHBnwVfiCTQPR5y9DExW68fcGQ',
    appId: '1:118234695516:web:b506b360e5100a9e59e399',
    messagingSenderId: '118234695516',
    projectId: 'image-crud-demo',
    authDomain: 'image-crud-demo.firebaseapp.com',
    storageBucket: 'image-crud-demo.appspot.com',
    measurementId: 'G-N59X0SMDVM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArGN-IgRxXW2EyD9v-i4-W6vaAZw-Vw30',
    appId: '1:118234695516:android:028762050390a14d59e399',
    messagingSenderId: '118234695516',
    projectId: 'image-crud-demo',
    storageBucket: 'image-crud-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcROrapwayXaq5-74j8HyLenmaKb1C2pk',
    appId: '1:118234695516:ios:2769e64d488fcf7359e399',
    messagingSenderId: '118234695516',
    projectId: 'image-crud-demo',
    storageBucket: 'image-crud-demo.appspot.com',
    iosClientId: '118234695516-9nguvf5p5d630us1t3k0m3n511ilq17p.apps.googleusercontent.com',
    iosBundleId: 'com.example.imageCrudDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcROrapwayXaq5-74j8HyLenmaKb1C2pk',
    appId: '1:118234695516:ios:2769e64d488fcf7359e399',
    messagingSenderId: '118234695516',
    projectId: 'image-crud-demo',
    storageBucket: 'image-crud-demo.appspot.com',
    iosClientId: '118234695516-9nguvf5p5d630us1t3k0m3n511ilq17p.apps.googleusercontent.com',
    iosBundleId: 'com.example.imageCrudDemo',
  );
}
