import 'package:firebaseauth/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userID,
    super.name,
    super.email,
    super.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String userID) {
    return UserModel(
      userID: userID,
      name: json['name'],
      email: json['email'],
      profilePicture: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
