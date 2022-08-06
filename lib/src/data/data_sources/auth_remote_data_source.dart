import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final authResult = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = authResult.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'FAILED_TO_LOGIN_WITH_EMAIL_AND_PASSWORD',
      );
    }
    return UserModel(
      userID: user.uid,
      name: user.displayName,
      email: user.email,
      profilePicture: user.photoURL,
    );
  }
}
