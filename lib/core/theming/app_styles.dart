// lib/core/app_styles.dart

import 'package:flutter/material.dart';

class AppStyles {
  static const BoxDecoration primaryGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 21, 101, 192), // لون أزرق داكن (Primary Dark)
         Color.fromARGB(255, 178, 198, 211),
      ],
    ),
  );
}