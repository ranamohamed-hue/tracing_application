import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';
import 'package:tracing_app/feature/parent/screens/home_page.dart';
import 'package:tracing_app/feature/parent/screens/notification_page.dart';
import 'package:tracing_app/feature/parent/screens/profile_bage.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({super.key});

  @override
  State<ParentPage> createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int currentIndex = 0;

  final List<Widget> pages = [HomePage(), NotificationPage(), ProfileBage()];
  void onItemTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget _buildBottomNavBarItem({required IconData icon, required int index}) {
    bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onItemTap(index),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected
                  ? const Color.fromARGB(255, 217, 218, 219)
                  : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
          size: 25,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppStyles.primaryGradientDecoration,
        child: pages[currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavBarItem(icon: Icons.home, index: 0),
              _buildBottomNavBarItem(icon: Icons.notifications, index: 1),
              _buildBottomNavBarItem(icon: Icons.person, index: 2),
            ],
          ),
        ),
      ),
    );
  }
}
