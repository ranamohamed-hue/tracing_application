import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:tracing_app/feature/login/screens/splash_screen.dart';
import 'package:tracing_app/feature/login/screens/sign_in_page.dart';

// استيراد ملفات المصادقة
import 'package:tracing_app/feature/auth/cubit/auth_cubit.dart';
import 'package:tracing_app/feature/auth/cubit/auth_state.dart';
import 'package:tracing_app/feature/auth/data/repo/auth_repo.dart';
import 'package:tracing_app/feature/auth/data/repo/auth_repo_impl.dart';

// استيراد ملفات الثيم
import 'package:tracing_app/core/theming/app_theme.dart';
import 'package:tracing_app/core/theming/logic/theme_cubit.dart';
import 'package:tracing_app/core/theming/logic/theme_state.dart';

// استيراد الشاشات
import 'package:tracing_app/feature/location_page/screens/location_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // --- التعديل الرئيسي هنا ---
  // 1. نُنشئ نسخة من الريبو مباشرة
  final authRepo = AuthRepoImpl(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
  );

  // 2. نمرر هذه النسخة مباشرة للـ RepositoryProvider والـ AuthCubit
  runApp(
    RepositoryProvider<AuthRepo>.value(
      value: authRepo,
      child: MultiBlocProvider(
        providers: [
          // 3. نستخدم (_) بدلاً من (context) لأننا لا نحتاجها
          BlocProvider(
            create: (_) => AuthCubit(authRepo),
          ),
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

// باقي الكود لم يتغير
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tracing App',
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar', 'AE')],
          locale: const Locale('ar', 'AE'),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,
          home: const AuthWrapper(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthCheckingState) {
          return const SplashScreen();
        }
        if (state is AuthenticatedState) {
          return const LocationPage();
        }
        if (state is LoginLoadingState ||
            state is SignUpLoadingState ||
            state is LogoutLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const SignInPage();
      },
    );
  }
}