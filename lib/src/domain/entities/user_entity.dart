import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userID;
  final String? name;
  final String? email;
  final String? profilePicture;

  const UserEntity({
    required this.userID,
    this.email,
    this.name,
    this.profilePicture,
  });

  @override
  List<Object> get props => [userID];
}
