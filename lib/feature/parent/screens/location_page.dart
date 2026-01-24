import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(decoration: AppStyles.primaryGradientDecoration
    );
  }
}