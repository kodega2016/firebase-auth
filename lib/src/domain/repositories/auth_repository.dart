import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<AppError, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AppError, UserEntity>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<AppError, UserEntity>> getCurrentUser();
  Future<Either<AppError, void>> logout();
}
