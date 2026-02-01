import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracing_app/feature/auth/cubit/auth_state.dart';
import 'package:tracing_app/feature/auth/data/models/user_model.dart';
import 'package:tracing_app/feature/auth/data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitialState());

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
      (error) {
        emit(SignUpErrorState(error));
      },
      (userModel) {
        emit(SignUpSuccessState(userModel));
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final result = await authRepo.login(email: email, password: password);

    result.fold(
      (error) {
        emit(LoginErrorState(error));
      },
      (userModel) {
        emit(LoginSuccessState(userModel));
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final result = await authRepo.logout();
    result.fold(
      (error) {
        emit(LogoutErrorState(error));
      },
      (_) {
        emit(LogoutSuccessState());
      },
    );
  }
}
