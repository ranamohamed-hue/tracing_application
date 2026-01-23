import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracing_app/core/widgets/appbar_part.dart';
import 'package:tracing_app/feature/login/widgets/login_prompt_widget.dart';
import 'package:tracing_app/feature/login/widgets/text_form_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

  @override
  void dispose() {
    _useremail.dispose();
    _userpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: AppbarPart(title: "تسجيل الدخول"),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormFieldWidget(
                    title: "البريد الإلكتروني",
                    hinttext: "أدخل بريدك الإلكتروني",
                    keyboardtype: TextInputType.emailAddress,
                    controller: _useremail,
                    icon: Icons.email_outlined,
                    validatorr: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك أدخل البريد الإلكتروني";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        print("تم الضغط على 'هل نسيت كلمة المرور؟'");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'سيتم توجيهك لصفحة استعادة كلمة المرور',
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "هل نسيت كلمة المرور؟",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
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
                          if (_formKey.currentState!.validate()) {}
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // --- رابط إنشاء حساب جديد ---
                  LoginPromptWidget(
                    comment: "ليس لديك حساب؟ ",
                    action: "قم بإنشاء حساب الآن",
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
