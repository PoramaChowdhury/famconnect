import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserScheduleScreen extends StatefulWidget {
  const UserScheduleScreen({super.key});

  @override
  State<UserScheduleScreen> createState() => _UserScheduleScreenState();
}

class _UserScheduleScreenState extends State<UserScheduleScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final List<String> daysOfWeek = [
    'monday', 'tuesday', 'wednesday',
    'thursday', 'friday', 'saturday', 'sunday'
  ];

  final Map<String, TextEditingController> _controllers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final schedule = (doc.data()?['weekly_schedule'] ?? {}) as Map<String, dynamic>;

    for (final day in daysOfWeek) {
      _controllers[day] = TextEditingController(text: schedule[day] ?? '');
    }

    setState(() => isLoading = false);
  }

  Future<void> _saveSchedule() async {
    final updatedSchedule = {
      for (final day in daysOfWeek) day: _controllers[day]!.text.trim()
    };

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'weekly_schedule': updatedSchedule,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Schedule saved successfully')),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((_, c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: Text("Weekly Free Time")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            ...daysOfWeek.map((day) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
              label: Text('Save'),
              onPressed: _saveSchedule,
            )
          ],
        ),
      ),
    );
  }
}
