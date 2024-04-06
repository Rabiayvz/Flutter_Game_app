
import 'package:devilmath1/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_home_page.dart';  // Import your MyHomePage here

class MainPage extends StatelessWidget {
  const MainPage ({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is signed in
            return MyHomePage();  // Navigate to MyHomePage if user is authenticated
          } else {
            // User is not signed in
            return const LoginPage();   // Navigate to LoginPage if user is not authenticated
          }
        },
      ),
    );
  }
}
