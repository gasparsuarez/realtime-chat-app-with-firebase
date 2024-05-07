class UpdateProfileModel {
  final String name;
  final String lastName;

  UpdateProfileModel({
    required this.name,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
      };
}
