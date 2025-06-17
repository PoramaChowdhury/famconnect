import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final Map<String, TextEditingController> _controllers = {};

  final List<String> daysOfWeek = [
    'monday', 'tuesday', 'wednesday',
    'thursday', 'friday', 'saturday', 'sunday'
  ];

  bool isLoading = true;
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final data = doc.data()!;
    name = data['name'];
    email = data['email'];

    Map<String, dynamic> schedule = data['weekly_schedule'] ?? {};
    for (var day in daysOfWeek) {
      _controllers[day] = TextEditingController(text: schedule[day] ?? '');
    }

    setState(() => isLoading = false);
  }

  Future<void> _saveRoutine() async {
    final Map<String, String> updatedSchedule = {
      for (var day in daysOfWeek) day: _controllers[day]!.text.trim()
    };

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'weekly_schedule': updatedSchedule,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Routine updated successfully')),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text("Your Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("Email: $email", style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            Text("Weekly free time", style: Theme.of(context).textTheme.headlineSmall),
            ...daysOfWeek.map((day) => Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextField(
                controller: _controllers[day],
                decoration: InputDecoration(
                  labelText: day[0].toUpperCase() + day.substring(1),
                  border: OutlineInputBorder(),
                ),
              ),
            )),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save Routine'),
              onPressed: _saveRoutine,
            )
          ],
        ),
      ),
    );
  }
}
