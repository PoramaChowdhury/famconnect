import 'package:famconnect/features/auth/screens/login_screen.dart';
import 'package:famconnect/features/home/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService {
  // auth state changes
  handleAuthState() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  // sign out
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
