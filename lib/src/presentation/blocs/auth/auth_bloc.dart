import 'package:equatable/equatable.dart';
import 'package:firebaseauth/src/domain/usecases/login_request.dart';
import 'package:firebaseauth/src/domain/usecases/login_with_email_and_password.dart';
import 'package:firebaseauth/src/domain/usecases/register_request.dart';
import 'package:firebaseauth/src/domain/usecases/signup_with_email_and_password.dart';
import 'package:firebaseauth/src/presentation/blocs/app/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmailAndPassword loginWithEmailAndPassword;
  final SignupWithEmailAndPassword signupWithEmailAndPassword;
  final AppBloc appBloc;

  AuthBloc({
    required this.appBloc,
    required this.loginWithEmailAndPassword,
    required this.signupWithEmailAndPassword,
  }) : super(AuthInitial()) {
    on<LoginBtnPressed>((event, emit) async {
      emit(AuthLoading());

      final errorOrSuccess = await loginWithEmailAndPassword.call(
        LoginRequest(email: event.email, passowrd: event.password),
      );

      return errorOrSuccess
          .fold((error) => emit(AuthError(message: error.message)), (data) {
        emit(AuthSuccess());
        appBloc.add(AppLaunched());
      });
    });

    on<RegisterBtnPressed>((event, emit) async {
      emit(AuthLoading());

      final errorOrSuccess = await signupWithEmailAndPassword.call(
        RegisterRequest(
          name: event.name,
          email: event.email,
          passowrd: event.password,
        ),
      );

      appBloc.add(AppLaunched());
      return errorOrSuccess.fold(
          (error) => emit(AuthError(message: error.message)),
          (data) => emit(AuthSuccess()));
    });
  }
}
