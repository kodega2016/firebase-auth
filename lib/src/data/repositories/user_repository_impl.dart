import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<AppError, void>> createOrUpdateUser(UserEntity user) {
    // TODO: implement createOrUpdateUser
    throw UnimplementedError();
  }
}
