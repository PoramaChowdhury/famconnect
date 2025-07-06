import 'package:famconnect/features/familychat/ui/screens/family_chat_screen.dart';
import 'package:famconnect/features/home/ui/screens/home_screen.dart';
import 'package:famconnect/features/home/ui/widgets/bottom_nav_bar_indicator_widget.dart';
import 'package:famconnect/features/profiles/ui/screens/profile_screen.dart';
import 'package:famconnect/features/setting/ui/screen/update_name_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  int _currentIndex = 4;

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1:
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const EventCreatScreen()),
      // );
        break;
      case 2:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FamilyChatScreen()),
      );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text(
                'Update Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.edit),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateNameScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Change Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.password),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const UpdatePasswordScreen()),
                // );
              },
            ),
            //todo add theme change or what needed  and also create update password screen
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }
}