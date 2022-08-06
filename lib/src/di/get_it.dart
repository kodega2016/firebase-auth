import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/src/data/data_sources/auth_remote_data_source.dart';
import 'package:firebaseauth/src/data/repositories/auth_repository_impl.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';
import 'package:firebaseauth/src/domain/usecases/login_with_email_and_password.dart';
import 'package:firebaseauth/src/presentation/blocs/bloc/login_bloc.dart';
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
  getIt.registerLazySingleton<LoginWithEmailAndPassword>(
      () => LoginWithEmailAndPassword(authRepository: getIt()));

  //blocs
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginWithEmailAndPassword: getIt(),
    ),
  );
}
