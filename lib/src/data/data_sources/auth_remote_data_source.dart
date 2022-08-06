import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/src/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<UserModel?> get streamCurrentUser;
  Future<void> logout();

  Future<UserModel> signUpEmailAndPassword({
    required String name,
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

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel> signUpEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final authResult = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = authResult.user;
    user?.updateDisplayName(name);
    if (user == null) {
      throw FirebaseAuthException(
        code: 'FAILED_TO_SIGN_UP_WITH_EMAIL_AND_PASSWORD',
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
