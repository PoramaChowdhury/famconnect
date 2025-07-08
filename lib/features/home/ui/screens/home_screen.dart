import 'package:famconnect/app/asset_path.dart';
import 'package:famconnect/features/home/ui/widgets/bottom_nav_bar_indicator_widget.dart';
import 'package:famconnect/features/home/ui/widgets/grid_view_item.dart';
import 'package:famconnect/features/home/ui/widgets/home_app_bar.dart';
import 'package:famconnect/features/profiles/ui/screens/profile_screen.dart';
import 'package:famconnect/features/profiles/ui/screens/user_schedule_screen.dart';
import 'package:famconnect/features/setting/ui/screen/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../gps_tracker/screens/family_member_tracking_screen.dart';
import '../../../gps_tracker/screens/gps_tracker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 3, // Only Schedule item
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return GridViewItem(
                        icon: Lottie.asset(
                          AssetsPath.scheduleIcon,
                          height: 70,
                          width: 70,
                        ),
                        label: 'Schedule',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserScheduleScreen(),
                            ),
                          );
                        },
                      );
                    case 1:
                      return GridViewItem(
                        icon: Lottie.asset(
                          AssetsPath.scheduleIcon,
                          height: 70,
                          width: 70,
                        ),
                        label: 'find my family',

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FamilyMemberTrackingScreen(),
                            ),
                          );
                        },
                      );

                    case 2:
                      return GridViewItem(
                        icon: Lottie.asset(
                          AssetsPath.scheduleIcon,
                          height: 70,
                          width: 70,
                        ),
                        label: 'gps locator',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => FamilyMapScreen(userId: '2',),
                              builder: (context) {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  // Optionally show error or redirect to login
                                  return const Center(
                                    child: Text("User not logged in"),
                                  );
                                }
                                return FamilyMapScreen(userId: user.uid);
                              },
                            ),
                          );
                        },
                      );

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Stay on Home
        break;
      case 1:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const EventCreatScreen()),
        // );
        break;
      case 2:
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const FamilyChatScreen()),
        // );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
    }
  }
}
