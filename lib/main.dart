import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:lookout/pages/singup.dart';
import 'package:lookout/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBlypKNXnJhxBdw4YewgGdA89zdnA0fFtY",
      authDomain: "lookout-4ae4a.firebaseapp.com",
      projectId: "lookout-4ae4a",
      storageBucket: "lookout-4ae4a.appspot.com",
      messagingSenderId: "686149876402",
      appId: "1:686149876402:web:0407bed5acfb5e25d3a7ab",
      measurementId: "G-K414JYC5QK",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Music player",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: splash(),
    );
  }
}
