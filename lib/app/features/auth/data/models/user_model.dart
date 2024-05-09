import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class UserModel {
  final String name;
  final String email;
  final String lastName;
  final String? password;
  final String? uid;
  final int? isOnline;
  final String? imageUrl;

  UserModel({
    this.uid,
    this.isOnline,
    required this.name,
    required this.email,
    required this.lastName,
    this.password,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        isOnline: json['isOnline'],
        name: json['name'],
        email: json['email'],
        lastName: json['lastName'],
        imageUrl: json['imageUrl'] ?? '',
      );

  static UserEntity modelToUser(UserModel model) => UserEntity(
        uid: model.uid!,
        name: model.name,
        email: model.email,
        lastName: model.lastName,
        isOnline: model.isOnline!,
        imageUrl: model.imageUrl,
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'lastName': lastName,
        'email': email,
        'isOnline': isOnline,
      };
}
