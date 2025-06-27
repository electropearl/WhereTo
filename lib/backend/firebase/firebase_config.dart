import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBs6j1Zde2giRj8PMfHVWnhMFNSb-wcyg8",
            authDomain: "where-to-b7e849.firebaseapp.com",
            projectId: "where-to-b7e849",
            storageBucket: "where-to-b7e849.firebasestorage.app",
            messagingSenderId: "186117342620",
            appId: "1:186117342620:web:22dd4311454a672f7a7459"));
  } else {
    await Firebase.initializeApp();
  }
}
