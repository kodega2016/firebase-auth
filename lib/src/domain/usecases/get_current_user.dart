import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';
import 'package:firebaseauth/src/domain/usecases/usecase.dart';

import '../entities/no_params.dart';

class GetCurrentUser extends UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUser({required this.authRepository});

  @override
  Future<Either<AppError, UserEntity>> call(params) async {
    return authRepository.getCurrentUser();
  }
}
