part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginBtnPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginBtnPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterBtnPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterBtnPressed(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}
