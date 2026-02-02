import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracing_app/feature/auth/cubit/auth_state.dart';
import 'package:tracing_app/feature/auth/data/models/user_model.dart';
import 'package:tracing_app/feature/auth/data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitialState()) {
    // استدعاء التحقق من الحالة عند إنشاء الكيوبت
    _checkAuthStatus();
  }

  // تعديل دالة التحقق من حالة المستخدم
  Future<void> _checkAuthStatus() async {
    // *** التغيير الرئيسي هنا ***
    // عند بدء التحقق، أرسل حالة التحقق (السبلاش سكرين)
    emit(AuthCheckingState());

    final currentUser = await authRepo.getCurrentUser();

    currentUser.fold(
      (error) {
        // إذا لم يكن هناك مستخدم، ارجع للحالة الأولية (شاشة اللوغن)
        emit(AuthInitialState());
      },
      (userModel) {
        // إذا كان هناك مستخدم، انتقل إلى حالة المصادقة الناجحة
        emit(AuthenticatedState(userModel));
      },
    );
  }

  Future<void> signUp({
    required UserModel userModel,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    final result = await authRepo.signUp(
      userModel: userModel,
      password: password,
    );

    result.fold(
      (error) => emit(SignUpErrorState(error)),
      (userModel) => emit(AuthenticatedState(userModel)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final result = await authRepo.login(email: email, password: password);

    result.fold(
      (error) => emit(LoginErrorState(error)),
      (userModel) => emit(AuthenticatedState(userModel)),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final result = await authRepo.logout();
    result.fold(
      (error) => emit(LogoutErrorState(error)),
      (_) {
        emit(AuthInitialState());
      },
    );
  }
}