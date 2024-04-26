import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:flutter/material.dart';

class RegisterFormBloc {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repPasswordController = TextEditingController();

  ///
  ///  Return user model
  ///
  UserModel get userModel => UserModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        lastName: lastNameController.text,
      );

  ///
  /// Formkey for manage form states
  ///
  final formKey = GlobalKey<FormState>();

  ///
  /// Clear all controllers
  ///
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    lastNameController.clear();
    repPasswordController.clear();
  }

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
    if (passwordController.text.length < 6) {
      return 'Password must be a long';
    }
    return null;
  }
}
