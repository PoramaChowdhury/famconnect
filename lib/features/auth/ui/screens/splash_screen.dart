import 'dart:async';
import 'package:famconnect/features/auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:famconnect/features/home/ui/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuth();
  }

  Future<void> _navigateBasedOnAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');

    if (uid != null && uid.isNotEmpty) {
      Navigator.pushReplacementNamed(context, HomeScreen.name);
    } else {
      Navigator.pushReplacementNamed(context, LogInScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade700,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const Icon(Icons.family_restroom, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'FamConnect',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(flex: 3),
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
