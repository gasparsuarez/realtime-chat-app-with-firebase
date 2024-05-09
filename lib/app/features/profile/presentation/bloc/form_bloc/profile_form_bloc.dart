import 'package:firebase_realtime_chat_app/app/features/profile/data/models/models.dart';
import 'package:flutter/material.dart';

class ProfileFormBloc {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  UpdateProfileModel get updateModel => UpdateProfileModel(
        name: firstNameController.text,
        lastName: lastNameController.text,
      );
}
