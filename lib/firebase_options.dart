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
    apiKey: 'AIzaSyDAxYGXyK3NrVrEXeIIGNPGUDKNfoDsUyo',
    appId: '1:817118585641:web:fa14d1a9c13fd0b802cd38',
    messagingSenderId: '817118585641',
    projectId: 'travelzone-908f0',
    authDomain: 'travelzone-908f0.firebaseapp.com',
    storageBucket: 'travelzone-908f0.appspot.com',
    measurementId: 'G-9RL8YPCNS7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKUGbs4pTgZUf7kjvI5XjWLbWafZrh3ZU',
    appId: '1:817118585641:android:c735fd6fc095c3f202cd38',
    messagingSenderId: '817118585641',
    projectId: 'travelzone-908f0',
    storageBucket: 'travelzone-908f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEzTwtlc2XHDQDE5CqHX88-RDA8Q8yr2Q',
    appId: '1:817118585641:ios:7b23daffab904b3b02cd38',
    messagingSenderId: '817118585641',
    projectId: 'travelzone-908f0',
    storageBucket: 'travelzone-908f0.appspot.com',
    androidClientId: '817118585641-2ekgan795urfdfvd7mt31ar5supo3cfn.apps.googleusercontent.com',
    iosClientId: '817118585641-62v0c4i2jebegi1p529eu9isp7npnrrk.apps.googleusercontent.com',
    iosBundleId: 'com.example.friendzone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEzTwtlc2XHDQDE5CqHX88-RDA8Q8yr2Q',
    appId: '1:817118585641:ios:7b23daffab904b3b02cd38',
    messagingSenderId: '817118585641',
    projectId: 'travelzone-908f0',
    storageBucket: 'travelzone-908f0.appspot.com',
    androidClientId: '817118585641-2ekgan795urfdfvd7mt31ar5supo3cfn.apps.googleusercontent.com',
    iosClientId: '817118585641-62v0c4i2jebegi1p529eu9isp7npnrrk.apps.googleusercontent.com',
    iosBundleId: 'com.example.friendzone',
  );
}
