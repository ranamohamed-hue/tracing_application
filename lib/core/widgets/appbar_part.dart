import 'package:flutter/material.dart';

class AppbarPart extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarPart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,

      toolbarHeight: 120.0,

      backgroundColor: Colors.transparent,

      elevation: 0,

      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 90.0),
              Positioned(
                left: 13,
                top: 9,
                child: Icon(
                  Icons.directions_walk,
                  color: Colors.black,
                  size: 65.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0); // يجب أن يطابق قيمة toolbarHeight
}
