import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';
import 'package:tracing_app/core/widgets/elevated_button_widget.dart';
import 'package:tracing_app/feature/parent/screens/location_page.dart';
import 'package:tracing_app/feature/parent/screens/video_call_page.dart';
import 'package:tracing_app/feature/parent/screens/voice_call_page.dart';
import 'package:tracing_app/core/widgets/appbar_part.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: AppStyles.primaryGradientDecoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      const AppbarPart(title: "اسم التطبيق"),
            const Text(
              "مرحبا : اسم ولي الأمر",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
      
            const SizedBox(height: 40),
      
            ElevatedButtonWidget(
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationPage()),
                );
              },
              title: "عرض الموقع الجغرافي",
              icon: Icons.location_on_outlined,
            ),
      
            const SizedBox(height: 40),
      
            Row(
              children: [
                ElevatedButtonWidget(
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VideoCallPage(),
                      ),
                    );
                  },
                  title: "مكالمة فيديو",
                  icon: Icons.video_call_outlined,
                ),
      
                const Spacer(),
      
                ElevatedButtonWidget(
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VoiceCallPage(),
                      ),
                    );
                  },
                  title: "مكالمة صوتية",
                  icon: Icons.phone_callback,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
