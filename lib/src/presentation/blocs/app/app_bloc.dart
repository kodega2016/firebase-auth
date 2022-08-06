import 'package:equatable/equatable.dart';
import 'package:firebaseauth/src/domain/entities/no_params.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/usecases/get_current_user.dart';
import 'package:firebaseauth/src/domain/usecases/logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetCurrentUser getCurrentUser;
  final Logout logout;

  AppBloc({
    required this.getCurrentUser,
    required this.logout,
  }) : super(const AppState(authState: AuthenticationState.uninitialized)) {
    on<AppLaunched>((event, emit) async {
      emit(const AppState(authState: AuthenticationState.authenticating));
      final errorOrSuccess = await getCurrentUser.call(NoParams());
      errorOrSuccess.fold(
        (error) => emit(
            const AppState(authState: AuthenticationState.unauthenticated)),
        (data) => emit(
          AppState(authState: AuthenticationState.authenticated, user: data),
        ),
      );
    });

    on<LogoutBtnPressed>((event, emit) async {
      emit(const AppState(authState: AuthenticationState.authenticating));
      await logout.call(NoParams());
      emit(const AppState(authState: AuthenticationState.unauthenticated));
    });
  }
}
