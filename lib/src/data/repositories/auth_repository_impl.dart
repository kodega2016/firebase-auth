import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/src/data/data_sources/auth_remote_data_source.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<AppError, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(AppError(message: e.message ?? ''));
    } catch (e) {
      return Left(AppError(message: e.toString()));
    }
  }
}
