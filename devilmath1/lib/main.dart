
import 'package:devilmath1/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDGFc4W-X8PXmC-u4XCk6h6urE7dAWPLqU",
      appId: "1:713405357856:android:ce07bb14c3aa82080fc145",
      messagingSenderId: "713405357856",
      projectId: "devilmath1-f007e",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devil\'s Math',
      home: LoginPage(), // Remove the comma and instantiate MainPage with parentheses
    );
  }
}

