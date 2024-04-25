class CreateUserDto {
  final String name;
  final String email;
  final String lastName;
  final String password;

  CreateUserDto({
    required this.name,
    required this.email,
    required this.password,
    required this.lastName,
  });

  toJson() => {
        'name': name,
        'email': email,
        'lastName': lastName,
        'password': password,
      };
}
