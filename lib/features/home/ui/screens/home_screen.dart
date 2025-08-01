import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famconnect/features/dinner_booking/screen/dinner_booking_screen.dart';
import 'package:famconnect/features/event_create/ui/screen/event_create_screen.dart';
import 'package:famconnect/features/gifts/screens/gift_suggestion_screen.dart';
import 'package:famconnect/features/gps_tracker/screens/family_member_tracking_screen.dart';
import 'package:famconnect/features/gps_tracker/screens/gps_tracker_screen.dart';
import 'package:famconnect/features/smart_dinner/ui/screen/smart_dinner_booking_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:famconnect/app/asset_path.dart';
import 'package:famconnect/features/familychat/ui/screens/family_chat_screen.dart';
import 'package:famconnect/features/home/ui/widgets/bottom_nav_bar_indicator_widget.dart';
import 'package:famconnect/features/home/ui/widgets/grid_view_item.dart';
import 'package:famconnect/features/home/ui/widgets/home_app_bar.dart';
import 'package:famconnect/features/profiles/ui/screens/profile_screen.dart';
import 'package:famconnect/features/profiles/ui/screens/user_schedule_screen.dart';
import 'package:famconnect/features/setting/ui/screen/settings_screen.dart';

import 'package:famconnect/features/familychat/ui/widgets/user_model.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  UserModel? _currentUser;


  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          _currentUser = UserModel.fromMap(data, uid);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to load user data")));
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        break; // Stay on home
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EventCreateScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FamilyChatScreen()),
        );
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
                  mainAxisSpacing: 10,
                ),

                itemCount: 7, // Only Schedule item
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
                    case 3:
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
                              // builder: (context) => FamilyMapScreen(userId: '2',),
                              builder: (context) {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  // Optionally show error or redirect to login
                                  return const Center(
                                    child: Text("User not logged in"),
                                  );
                                }
                                return UserScheduleScreen();
                              },
                            ),
                          );
                        },
                      );
                    case 4:
                      return GridViewItem(
                        icon: Lottie.asset(
                          AssetsPath.scheduleIcon,
                          height: 70,
                          width: 70,

                        ),
                        label: 'Gift Suggestion ',
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
                                return GiftSuggestionScreen();
                              },
                            ),
                          );
                        },
                      );
                    case 5:
                      return GridViewItem(
                        icon: Lottie.asset(
                          AssetsPath.scheduleIcon,
                          height: 70,
                          width: 70,

                        ),
                        label: 'Core management',
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
                                return GiftSuggestionScreen();
                              },
                            ),
                          );
                        },
                      );

                    case 6:
                      return GridViewItem(
                        icon: Lottie.asset(
                          AssetsPath.scheduleIcon,
                          height: 70,
                          width: 70,

                        ),
                        label: 'Diner booking',
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
                                return AllUsersFreeTimeScreen ();
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


/*
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
*/

}
