import 'package:flutter/material.dart';

class ProfileBage extends StatefulWidget {
  const ProfileBage({super.key});

  @override
  State<ProfileBage> createState() => _ProfileBageState();
}

class _ProfileBageState extends State<ProfileBage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        child: Center(child: Text("الملف الشخصي"))),
    );
  }
}
