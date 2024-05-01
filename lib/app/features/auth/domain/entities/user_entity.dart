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
}
