import 'package:firebase_realtime_chat_app/app/core/core.dart';

class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String lastName;
  final int isOnline;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.lastName,
    required this.isOnline,
  });

  bool get isOnlineUser => isOnline == 1 ? true : false;

  String get fullName => '${name.capitalize} ${lastName.capitalize}';
}
