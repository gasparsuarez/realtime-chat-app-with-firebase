import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

class LoginFormBloc {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? validateForm() {
    formKey.currentState!.validate();
    if (!Validators.validateEmail(emailController.text)) {
      return 'Enter a valid email';
    }
    if (passController.text.length < 6) {
      return 'Password must be a long';
    }
    return null;
  }
}
