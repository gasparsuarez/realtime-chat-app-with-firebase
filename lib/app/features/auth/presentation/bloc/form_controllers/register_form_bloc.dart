import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter/material.dart';

class RegisterFormBloc {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repPasswordController = TextEditingController();

  ///
  ///  Return DTO with user data
  ///
  CreateUserDto get userDto => CreateUserDto(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        lastName: lastNameController.text,
      );

  final formKey = GlobalKey<FormState>();

  String? validateForm() {
    formKey.currentState!.validate();

    if (nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repPasswordController.text.isEmpty) {
      return 'All fields is required';
    }
    if (!Validators.validateEmail(emailController.text)) {
      return 'Enter a valid email';
    }
    if (passwordController.text != repPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
