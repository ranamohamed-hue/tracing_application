import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: AppStyles.primaryGradientDecoration,
        child: Center(
          child: Text("مكالمة فيديو ",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        ),
      )
    );
  }
}