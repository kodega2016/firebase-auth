import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<UserModel?> get streamCurrentUser;
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

  @override
  Stream<UserModel?> get streamCurrentUser {
    return firebaseAuth.userChanges().map((event) {
      if (event?.uid == null) return null;
      return UserModel(
        userID: event!.uid,
        email: event.email,
        name: event.displayName,
        profilePicture: event.photoURL,
      );
    });
  }
}
