import 'package:equatable/equatable.dart';
import 'package:tracing_app/feature/auth/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// الحالة الأولية عند بدء التطبيق (قبل التحقق من المستخدم)
class AuthInitialState extends AuthState {}
class AuthCheckingState extends AuthState {}
// حالة التحميل: تُستخدم عند بدء التطبيق للتحقق من المستخدم المسجل دخوله
class AuthLoadingState extends AuthState {}

// حالة المصادقة الناجحة: تعني أن المستخدم مسجل دخوله بالفعل
class AuthenticatedState extends AuthState {
  final UserModel userModel;

  const AuthenticatedState(this.userModel);

  @override
  List<Object> get props => [userModel];
}

// --- حالات التسجيل (Sign Up) ---
class SignUpLoadingState extends AuthState {}
class SignUpSuccessState extends AuthState {
  final UserModel userModel;

  const SignUpSuccessState(this.userModel);

  @override
  List<Object> get props => [userModel];
}
class SignUpErrorState extends AuthState {
  final String error;

  const SignUpErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// --- حالات تسجيل الدخول (Login) ---
class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {
  final UserModel userModel;

  const LoginSuccessState(this.userModel);

  @override
  List<Object> get props => [userModel];
}
class LoginErrorState extends AuthState {
  final String error;

  const LoginErrorState(this.error);

  @override
  List<Object> get props => [error];
}

// --- حالات تسجيل الخروج (Logout) ---
class LogoutLoadingState extends AuthState {}
class LogoutSuccessState extends AuthState {}
class LogoutErrorState extends AuthState {
  final String error;

  const LogoutErrorState(this.error);

  @override
  List<Object> get props => [error];
}