import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restaurant_app/utils/constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key, required this.onTabCallback})
      : super(key: key);

  final void Function(int) onTabCallback;

  @override
  Widget build(BuildContext context) {
    return GNav(
      onTabChange: (index) {
        onTabCallback(index);
      },
      tabMargin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: EdgeInsets.all(12.0),
      iconSize: 24,
      curve: Curves.easeInExpo,
      duration: Duration(milliseconds: 900),
      gap: 8.0,
      haptic: true,
      color: darkGreen,
      activeColor: Colors.white,
      tabBackgroundColor: darkGreen,
      backgroundColor: lightGreen,
      tabs: [
        GButton(
          icon: Icons.home_outlined,
          text: 'Home',
        ),
        GButton(
          icon: Icons.search_outlined,
          text: 'Search',
        ),
        GButton(
          icon: Icons.bookmark_border_outlined,
          text: 'Saved',
        ),
        GButton(
          icon: Icons.person_outline,
          text: 'Profile',
        ),
      ],
    );
  }
}
