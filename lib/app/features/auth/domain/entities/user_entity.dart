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

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        lastName: json['lastName'],
        isOnline: json['isOnline'],
      );

  toJson() => {
        'name': name,
        'email': email,
        'lastName': lastName,
        'isOnline': isOnline,
      };
}
