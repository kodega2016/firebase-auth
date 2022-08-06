import 'package:firebaseauth/src/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> createOrUpdateUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<void> createOrUpdateUser(UserModel user) {
    // TODO: implement createOrUpdateUser
    throw UnimplementedError();
  }
}
