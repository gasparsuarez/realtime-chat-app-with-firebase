import 'package:flutter/material.dart';

class RegisterFormBloc {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
}
