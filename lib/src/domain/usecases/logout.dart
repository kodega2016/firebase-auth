import 'package:dartz/dartz.dart';
import 'package:firebaseauth/src/domain/entities/app_error.dart';
import 'package:firebaseauth/src/domain/entities/no_params.dart';
import 'package:firebaseauth/src/domain/repositories/auth_repository.dart';
import 'package:firebaseauth/src/domain/usecases/usecase.dart';

class Logout extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  Logout({required this.authRepository});

  @override
  Future<Either<AppError, void>> call(NoParams params) async {
    return authRepository.logout();
  }
}
