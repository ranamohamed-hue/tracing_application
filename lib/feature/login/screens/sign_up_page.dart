import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. استيراد Bloc
import 'package:tracing_app/core/theming/app_styles.dart';
import 'package:tracing_app/core/widgets/appbar_part.dart';
import 'package:tracing_app/feature/auth/cubit/auth_cubit.dart'; // 2. استيراد AuthCubit
import 'package:tracing_app/feature/auth/cubit/auth_state.dart'; // 3. استيراد AuthState
import 'package:tracing_app/feature/auth/data/models/user_model.dart'; // 4. استيراد UserModel
import 'package:tracing_app/feature/login/widgets/login_prompt_widget.dart';
import 'package:tracing_app/feature/login/widgets/text_form_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController(); // تم تصحيح الاسم
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();

  String _userRole = 'طالب';

  @override
  void dispose() {
    _username.dispose(); // تم تصحيح الاسم
    _useremail.dispose();
    _userpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 5. إضافة BlocListener للاستماع لتغييرات الحالة
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // عند نجاح إنشاء الحساب، انتقل لصفحة الموقع
        if (state is SignUpSuccessState || state is AuthenticatedState) {
          Navigator.of(context).pushReplacementNamed('/location');
        }
        // عند حدوث خطأ، اعرض رسالة
        if (state is SignUpErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
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
                      controller: _username, // تم تصحيح الاسم
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
                      obscureText: true, // إضافة لإخفاء كلمة المرور
                      validatorr: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك أدخل كلمة المرور";
                        }
                        // ملاحظة: 10 أحرف طويل جداً، يمكنك تقليله إلى 6
                        if (value.length < 10) {
                          return "كلمة المرور ينبغي أن تكون على الأقل 10 أحرف";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // قسم اختيار نوع المستخدم
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

                    // 6. إضافة BlocBuilder للزر للتعامل مع حالة التحميل
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is SignUpLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }

                        return Center(
                          child: SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.person_add_outlined), // أيقونة أنسب
                              label: const Text("إنشاء حساب جديد"),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // 7. إنشاء UserModel واستدعاء دالة signUp
                                  final newUser = UserModel(
                                    uid: '', // سيتم ملؤه في الـ Repo
                                    username: _username.text,
                                    email: _useremail.text,
                                    userType: _userRole, // استخدام الدور المختار
                                  );

                                  context.read<AuthCubit>().signUp(
                                        userModel: newUser,
                                        password: _userpassword.text,
                                      );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // 8. إضافة onPressed للعودة لصفحة الدخول
                    LoginPromptWidget(
                      comment: "هل لديك حساب من قبل؟",
                      action: "قم بتسجيل الدخول الآن",
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}