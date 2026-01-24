import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';
import 'package:tracing_app/core/widgets/appbar_part.dart';
import 'package:tracing_app/core/widgets/elevated_button_widget.dart';
import 'package:tracing_app/feature/parent/screens/video_call_page.dart';
import 'package:tracing_app/feature/parent/screens/voice_call_page.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarPart(title: "اسم التطبيق"),
      body: Container(
        decoration: AppStyles.primaryGradientDecoration,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "مرحبا : اسم ولي الأمر",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              ElevatedButtonWidget(
                onpress: () {},
                title: "تفعيل الموقع الجغرافي",
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
                          builder: (context) => const VoiceCallPage(),
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
                          builder: (context) => const VideoCallPage(),
                        ),
                      );
                    },
                    title: "مكالمة صوتية",
                    icon: Icons.phone_callback,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButtonWidget(
                onpress: () {},
                title: " فتح في CHAT GPT ",
                icon: Icons.link_sharp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
