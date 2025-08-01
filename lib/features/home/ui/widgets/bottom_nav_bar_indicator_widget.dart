import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavBarTapped;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onNavBarTapped,
  });

  @override
  Widget build(BuildContext context) {
    return CustomLineIndicatorBottomNavbar(
      selectedColor: Colors.teal,
      unSelectedColor: Colors.grey,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onNavBarTapped,
      enableLineIndicator: true,
      lineIndicatorWidth: 3,
      customBottomBarItems: [
        CustomBottomBarItems(
          label: 'Home',
          icon: Icons.home,
        ),
         CustomBottomBarItems(
          label: 'Event',
          icon: Icons.event,
        ),
         CustomBottomBarItems(
          label: 'Chat',
          icon: Icons.chat,
        ),
         CustomBottomBarItems(
          label: 'Profile',
          icon: Icons.person,
        ),
         CustomBottomBarItems(
          label: 'Setting',
          icon: Icons.settings,
        ),
      ],
    );
  }
}
