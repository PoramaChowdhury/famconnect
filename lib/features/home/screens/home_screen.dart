import 'package:famconnect/features/auth/services/auth_service.dart';
import 'package:famconnect/features/profiles/screens/user_schedule_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FamConnect Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => AuthService().signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user?.email}'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("View Profile"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ScheduleScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
