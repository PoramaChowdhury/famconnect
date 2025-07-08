import 'package:famconnect/features/auth/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FamConnectApp());
}

class FamConnectApp extends StatefulWidget {
  const FamConnectApp({super.key});

  @override
  State<FamConnectApp> createState() => _FamConnectAppState();
}

class _FamConnectAppState extends State<FamConnectApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FamConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: AuthService().handleAuthState(),
    );
  }
}
