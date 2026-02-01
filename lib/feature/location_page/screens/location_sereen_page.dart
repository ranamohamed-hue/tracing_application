import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';
import 'package:tracing_app/core/widgets/appbar_part.dart';
import 'package:tracing_app/feature/login/widgets/login_prompt_widget.dart';
import 'package:tracing_app/feature/login/widgets/text_form_field_widget.dart';

class LocationScreenPage extends StatefulWidget {
  const LocationScreenPage({super.key});

  @override
  State<LocationScreenPage> createState() => _LocationScreenPageState();
}

class _LocationScreenPageState extends State<LocationScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernamee = TextEditingController();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

  // متغير لتخزين نوع المستخدم المختار
  String _userRole = 'طالب'; // القيمة الافتراضية هي "طالب"

  @override
  void dispose() {
    _usernamee.dispose();
    _useremail.dispose();
    _userpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarPart(title: " انشاء حساب جديد"),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: AppStyles.primaryGradientDecoration,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // user name
                  TextFormFieldWidget(
                    title: "اسم المستخدم",
                    hinttext: "أدخل اسم المستخدم",
                    keyboardtype: TextInputType.name,
                    controller: _usernamee,
                    icon: Icons.person,
                    validatorr: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل اسم المستخدم";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // user Email
                  TextFormFieldWidget(
                    title: "البريد الإلكتروني",
                    hinttext: "أدخل البريد الإلكتروني",
                    keyboardtype: TextInputType.emailAddress,
                    controller: _useremail,
                    icon: Icons.email_outlined,
                    validatorr: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل البريد الإلكتروني";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "البريد الإلكتروني غير صالح";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // user password
                  TextFormFieldWidget(
                    title: "كلمة المرور",
                    hinttext: "أدخل كلمة المرور",
                    keyboardtype: TextInputType.visiblePassword,
                    controller: _userpassword,
                    icon: Icons.lock,
                    validatorr: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل كلمة المرور";
                      }
                      if (value.length < 10) {
                        return "كلمة المرور ينبغي أن تكون على الأقل 10 أحرف";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

                  // قسم اختيار نوع المستخدم مع الأيقونات (ترتيب عمودي)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "نوع المستخدم",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // تم حذف الـ Row و Expanded ليصبح الترتيب عمودياً
                        RadioListTile<String>(
                          title: const Text("طالب"),
                          secondary: Icon(
                            Icons.school,
                            color: Theme.of(context).primaryColor,
                          ),
                          value: 'طالب',
                          groupValue: _userRole,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _userRole = value!;
                            });
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                        ),
                        RadioListTile<String>(
                          title: const Text("ولي أمر"),
                          secondary: Icon(
                            Icons.family_restroom,
                            color: Theme.of(context).primaryColor,
                          ),
                          value: 'ولي أمر',
                          groupValue: _userRole,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _userRole = value!;
                            });
                          },
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.verified_outlined),
                        label: const Text("إنشاء حساب جديد"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // يمكنك الآن استخدام القيمة المختارة _userRole
                            print('الدور المختار: $_userRole');
                            // تابع مع عملية إرسال النموذج...
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const LoginPromptWidget(
                    comment: "هل لديك حساب من قبل؟",
                    action: "قم بتسجيل الدخول الآن",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
