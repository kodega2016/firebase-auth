import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/user_entity.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';
import 'package:firebaseauth/src/domain/usecases/register_request.dart';
import 'package:firebaseauth/src/domain/usecases/usecase.dart';

class SignupWithEmailAndPassword extends UseCase<UserEntity, RegisterRequest> {
  final AuthRepository authRepository;
  SignupWithEmailAndPassword({required this.authRepository});

  @override
  Future<Either<AppError, UserEntity>> call(RegisterRequest params) async {
    return await authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.passowrd,
    );
  }
}
