import 'package:flutter/material.dart';
import 'package:tracing_app/core/theming/app_styles.dart';
import 'package:tracing_app/core/widgets/appbar_part.dart';
import 'package:tracing_app/feature/login/widgets/login_prompt_widget.dart'; 
import 'package:tracing_app/feature/login/widgets/text_form_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernamee = TextEditingController();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

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
      body: Container(decoration: AppStyles.primaryGradientDecoration,
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
                  const SizedBox(height: 20),
          
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.verified_outlined),
                        label: const Text("إنشاء حساب جديد"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
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
