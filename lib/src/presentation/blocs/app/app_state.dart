part of 'app_bloc.dart';

enum AuthenticationState {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating
}

class AppState extends Equatable {
  final AuthenticationState authState;
  final UserEntity? user;

  const AppState({
    required this.authState,
    this.user,
  });

  @override
  List<Object> get props => [authState];
}
