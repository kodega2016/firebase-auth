import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';
import 'package:firebaseauth/src/domain/usecases/usecase.dart';

import 'login_request.dart';

class LoginWithEmailAndPassword extends UseCase<UserEntity, LoginRequest> {
  final AuthRepository authRepository;
  LoginWithEmailAndPassword({required this.authRepository});

  @override
  Future<Either<AppError, UserEntity>> call(params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.passowrd,
    );
  }
}
