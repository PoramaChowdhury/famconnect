import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class UserScheduleScreen extends StatefulWidget {
  const UserScheduleScreen({super.key});

  @override
  State<UserScheduleScreen> createState() => _UserScheduleScreenState();
}

class _UserScheduleScreenState extends State<UserScheduleScreen> {
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<Map<String, String>>> _events = {};

  // void _addEvent(String status, String description) {
  //   final key = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
  //   if (_events[key] == null) {
  //     _events[key] = [];
  //   }
  //   if (_events[key]!.length < 2) {
  //     _events[key]!.add({"status": status, "description": description});
  //     setState(() {});
  //   }
  // }

  // void _showAddDialog() {
  //   final statusController = TextEditingController();
  //   final descController = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text("Add Schedule"),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           DropdownButtonFormField<String>(
  //             value: "Busy",
  //             items: const [DropdownMenuItem(value: "Busy", child: Text("Busy")), DropdownMenuItem(value: "Free", child: Text("Free"))],
  //             onChanged: (value) => statusController.text = value ?? "Busy",
  //             decoration: const InputDecoration(labelText: "Status"),
  //           ),
  //           TextField(
  //             controller: descController,
  //             decoration: const InputDecoration(labelText: "Description"),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               _addEvent(statusController.text.isEmpty ? "Busy" : statusController.text, descController.text);
  //               Navigator.pop(context);
  //             },
  //             child: const Text("Add"))
  //       ],
  //     ),
  //   );
  // }
  void _addEvent(String status, String description, String timeRange) {
    final key = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    if (_events[key] == null) {
      _events[key] = [];
    }
    if (_events[key]!.length < 2) {
      final label = description.trim().isEmpty ? status : description;
      _events[key]!.add({"status": status, "description": "$label at $timeRange"});
      setState(() {});
    }
  }


  void _showAddDialog() {
    String selectedStatus = "Busy";
    final descController = TextEditingController();
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text("Add Schedule"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: const [
                  DropdownMenuItem(value: "Busy", child: Text("Busy")),
                  DropdownMenuItem(value: "Free", child: Text("Free")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setStateDialog(() => selectedStatus = value);
                  }
                },
                decoration: const InputDecoration(labelText: "Status"),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setStateDialog(() => startTime = time);
                  }
                },
                child: Text(startTime == null
                    ? 'Select Start Time'
                    : 'Start: ${startTime!.format(context)}'),
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setStateDialog(() => endTime = time);
                  }
                },
                child: Text(endTime == null
                    ? 'Select End Time'
                    : 'End: ${endTime!.format(context)}'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (startTime != null && endTime != null) {
                  final timeRange =
                      '${startTime!.format(context)} - ${endTime!.format(context)}';
                  _addEvent(
                    selectedStatus,
                    descController.text,
                    timeRange,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            )
          ],
        ),
      ),
    );
  }



  Widget _buildEventList() {
    final key = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final events = _events[key] ?? [];
    return Column(
      children: events
          .map((e) => Card(
        color: e["status"] == "Busy" ? Colors.deepOrangeAccent.withOpacity(0.2) : Colors.lightBlueAccent.withOpacity(0.2),
        child: ListTile(
          title: Text(e["status"]!),
          subtitle: Text(e["description"]!),
        ),
      ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weekly Scheduler")),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          const SizedBox(height: 10),
          _buildEventList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
