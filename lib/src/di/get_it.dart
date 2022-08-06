import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/src/data/data_sources/auth_remote_data_source.dart';
import 'package:firebaseauth/src/data/repositories/auth_repository_impl.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';
import 'package:firebaseauth/src/domain/usecases/get_current_user.dart';
import 'package:firebaseauth/src/domain/usecases/login_with_email_and_password.dart';
import 'package:firebaseauth/src/domain/usecases/logout.dart';
import 'package:firebaseauth/src/domain/usecases/signup_with_email_and_password.dart';
import 'package:firebaseauth/src/presentation/blocs/app/app_bloc.dart';
import 'package:firebaseauth/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void init() {
  //core
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  //data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(firebaseAuth: getIt()));

  //repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: getIt()));

  //usecases

  getIt.registerLazySingleton<GetCurrentUser>(
      () => GetCurrentUser(authRepository: getIt()));

  getIt.registerLazySingleton<Logout>(() => Logout(authRepository: getIt()));

  getIt.registerLazySingleton<LoginWithEmailAndPassword>(
      () => LoginWithEmailAndPassword(authRepository: getIt()));

  getIt.registerLazySingleton<SignupWithEmailAndPassword>(
      () => SignupWithEmailAndPassword(authRepository: getIt()));

  //blocs
  getIt.registerFactory<AppBloc>(
    () => AppBloc(
      getCurrentUser: getIt(),
      logout: getIt(),
    ),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      appBloc: getIt(),
      loginWithEmailAndPassword: getIt(),
      signupWithEmailAndPassword: getIt(),
    ),
  );
}
