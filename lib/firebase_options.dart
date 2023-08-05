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
    apiKey: 'AIzaSyDddPfW3S5heMXOsOj7ZjGzK8Dk4qGNgIA',
    appId: '1:463677421958:web:fcde32b1f9f2df356d1407',
    messagingSenderId: '463677421958',
    projectId: 'bellehouse',
    authDomain: 'bellehouse.firebaseapp.com',
    storageBucket: 'bellehouse.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOY755druLwM5OVnkg7n_lP7fRJXy244A',
    appId: '1:463677421958:android:58367483a61f619c6d1407',
    messagingSenderId: '463677421958',
    projectId: 'bellehouse',
    storageBucket: 'bellehouse.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtpjXwDfVhQpHQMMMD9fHTqOunbIP9tOk',
    appId: '1:463677421958:ios:91a20fe02fa67b926d1407',
    messagingSenderId: '463677421958',
    projectId: 'bellehouse',
    storageBucket: 'bellehouse.appspot.com',
    iosClientId: '463677421958-834tfejdo34mgpkf1uvlp8c9ceck4837.apps.googleusercontent.com',
    iosBundleId: 'com.bellehouseniger.bellehouse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtpjXwDfVhQpHQMMMD9fHTqOunbIP9tOk',
    appId: '1:463677421958:ios:b762f4ab8b9645506d1407',
    messagingSenderId: '463677421958',
    projectId: 'bellehouse',
    storageBucket: 'bellehouse.appspot.com',
    iosClientId: '463677421958-7ko21lo6185rq2nk6p5mjhgm55hf7bfb.apps.googleusercontent.com',
    iosBundleId: 'com.bellehouseniger.bellehouse.RunnerTests',
  );
}
