import 'package:equatable/equatable.dart';
import 'package:firebaseauth/src/domain/entities/no_params.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/usecases/get_current_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetCurrentUser getCurrentUser;

  AppBloc({required this.getCurrentUser})
      : super(const AppState(authState: AuthState.uninitialized)) {
    on<AppLaunched>((event, emit) async {
      emit(const AppState(authState: AuthState.authenticating));
      final errorOrSuccess = await getCurrentUser.call(NoParams());
      errorOrSuccess.fold(
          (error) => emit(const AppState(authState: AuthState.unauthenticated)),
          (data) => emit(const AppState(authState: AuthState.authenticated)));
    });
  }
}
