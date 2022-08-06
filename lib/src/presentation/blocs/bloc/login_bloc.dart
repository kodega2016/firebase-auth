import 'package:equatable/equatable.dart';
import 'package:firebaseauth/src/domain/usecases/login_request.dart';
import 'package:firebaseauth/src/domain/usecases/login_with_email_and_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithEmailAndPassword loginWithEmailAndPassword;

  LoginBloc({required this.loginWithEmailAndPassword}) : super(LoginInitial()) {
    on<LoginBtnPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      final errorOrSuccess = await loginWithEmailAndPassword.call(
        LoginRequest(email: event.email, passowrd: event.password),
      );

      return errorOrSuccess.fold(
          (error) => emit(LoginError(message: error.message)),
          (data) => emit(LoginSuccecss()));
    });
  }
}
