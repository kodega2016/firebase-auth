import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<AppError, void>> createOrUpdateUser(UserEntity user);
}
