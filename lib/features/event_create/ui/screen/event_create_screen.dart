// import 'package:famconnect/features/common/ui/widgets/custom_app_bar.dart';
// import 'package:famconnect/features/familychat/ui/screens/family_chat_screen.dart';
// import 'package:famconnect/features/home/ui/screens/home_screen.dart';
// import 'package:famconnect/features/home/ui/widgets/bottom_nav_bar_indicator_widget.dart';
// import 'package:famconnect/features/profiles/ui/screens/profile_screen.dart';
// import 'package:famconnect/features/setting/ui/screen/settings_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class EventCreateScreen extends StatefulWidget {
//   const EventCreateScreen({super.key});
//
//   @override
//   State<EventCreateScreen> createState() => _EventCreateScreenState();
// }
//
// class _EventCreateScreenState extends State<EventCreateScreen> {
//   int _currentIndex = 0;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _initNotifications();
//   }
//   void _onNavBarTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//
//     switch (index) {
//       case 0:
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//         break; // Stay on home
//       case 1:
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => EventCreateScreen()),
//         // );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => FamilyChatScreen()),
//         );
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ProfileScreen()),
//         );
//         break;
//       case 4:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const SettingsScreen()),
//         );
//         break;
//     }
//   }
//
//   Future<void> _initNotifications() async {
//     tz.initializeTimeZones();
//     const AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     const InitializationSettings settings =
//     InitializationSettings(android: androidSettings);
//     await flutterLocalNotificationsPlugin.initialize(settings);
//   }
//
//   Future<void> _scheduleNotification(DateTime scheduledTime, String title) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Event Reminder',
//       title,
//       tz.TZDateTime.from(scheduledTime, tz.local),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'event_reminder', // channel ID
//           'Event Reminder', // channel name
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//       matchDateTimeComponents: DateTimeComponents.dateAndTime,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }
//
//   void _showCreateEventDialog() {
//     final titleController = TextEditingController();
//     DateTime selectedDate = DateTime.now();
//
//     showDialog(
//       context: context,
//       builder: (ctx) {
//         return AlertDialog(
//           title: const Text('Create Event'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: const InputDecoration(labelText: 'Event Title'),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 child: const Text('Pick Date'),
//                 onPressed: () async {
//                   final picked = await showDatePicker(
//                     context: context,
//                     initialDate: selectedDate,
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2100),
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       selectedDate = picked;
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => Navigator.pop(ctx),
//             ),
//             ElevatedButton(
//               child: const Text('Save'),
//               onPressed: () async {
//                 if (titleController.text.trim().isNotEmpty) {
//                   await FirebaseFirestore.instance.collection('events').add({
//                     'title': titleController.text.trim(),
//                     'date': selectedDate.toIso8601String(),
//                     'createdBy': 'user123', // Replace with actual user ID
//                   });
//
//                   final reminderDate = selectedDate.subtract(const Duration(days: 1));
//                   await _scheduleNotification(reminderDate, titleController.text);
//                 }
//                 Navigator.pop(ctx);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Stream<List<Map<String, dynamic>>> getEventsForSelectedDay(DateTime day) {
//     final selectedDateStr = DateFormat('yyyy-MM-dd').format(day);
//     return FirebaseFirestore.instance
//         .collection('events')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => doc.data())
//         .where((event) =>
//     DateFormat('yyyy-MM-dd').format(DateTime.parse(event['date'])) ==
//         selectedDateStr)
//         .toList()
//         .cast<Map<String, dynamic>>());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title:('Event')),
//       body: Column(
//         children: [
//           TableCalendar(
//             focusedDay: _focusedDay,
//             firstDay: DateTime.utc(2020, 1, 1),
//             lastDay: DateTime.utc(2030, 12, 31),
//             selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//               });
//             },
//           ),
//           Expanded(
//             child: StreamBuilder<List<Map<String, dynamic>>>(
//               stream: getEventsForSelectedDay(_selectedDay ?? DateTime.now()),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 final events = snapshot.data!;
//                 if (events.isEmpty) {
//                   return const Center(child: Text("No events for this day"));
//                 }
//                 return ListView.builder(
//                   itemCount: events.length,
//                   itemBuilder: (ctx, i) => ListTile(
//                     title: Text(events[i]['title'] ?? ''),
//                     subtitle: Text(
//                       DateFormat.yMMMd().format(DateTime.parse(events[i]['date'])),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton.icon(
//               onPressed: _showCreateEventDialog,
//               icon: const Icon(Icons.add),
//               label: const Text('Create Event'),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavBarWidget(
//         currentIndex: _currentIndex,
//         onNavBarTapped: _onNavBarTapped,
//       ),
//     );
//
//   }
// }

import 'package:flutter/material.dart';

class EventCreateScreen extends StatefulWidget {
  const EventCreateScreen({super.key});

  @override
  State<EventCreateScreen> createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
