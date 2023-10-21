import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDPKi7RHsv3jzTUZz_yooD08AOZIBrBu04',
    appId: '1:462880464068:web:00ac189afe3147174283b4',
    messagingSenderId: '462880464068',
    projectId: 'e-schoolsolutionconnect',
    authDomain: 'e-schoolsolutionconnect.firebaseapp.com',
    storageBucket: 'e-schoolsolutionconnect.appspot.com',
    measurementId: 'G-HVNGJMZVXR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPKi7RHsv3jzTUZz_yooD08AOZIBrBu04',
    appId: '1:462880464068:android:4529d2a23c38bfac61fd91',
    messagingSenderId: '462880464068',
    projectId: 'e-schoolsolutionconnect',
    storageBucket: 'e-schoolsolutionconnect.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMAToNblYQIp8lXuMVxQkl_oZGgF4o3NE',
    appId: '1:462880464068:ios:4c9103e24dea314261fd91',
    messagingSenderId: '462880464068',
    projectId: 'e-schoolsolutionconnect',
    storageBucket: 'e-schoolsolutionconnect.appspot.com',
    iosClientId:
        '462880464068-c71rdlgr51skua6nkl0i1t7vip2v6prl.apps.googleusercontent.com',
    iosBundleId: 'com.gjinfotech.essconnect',
  );
}
