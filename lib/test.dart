
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';


import 'package:flutter/foundation.dart';  // for kIsWeb and TargetPlatform
import 'package:flutter/services.dart';      // for PlatformException

class DefaultFirebaseOptionsTest {

  static FirebaseOptions get currentPlatform {
    // Check if the platform is web
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyB8bX9cpsixuQVUxIFcugfpdstJsDWwSt4',
        authDomain: 'test-ec1bf.firebaseapp.com',
        databaseURL: 'https://your-project-id.firebaseio.com',
        projectId: 'test-ec1bf',
        storageBucket: 'test-ec1bf.firebasestorage.app',
        messagingSenderId: '530097269490',
        appId: '1:530097269490:web:70326f46ddf2af5a607e6b',
        measurementId: 'your-measurement-id',
      );
    }
    else {
      throw UnsupportedError('Firebase options not configured for this platform');
    }
  }
}
