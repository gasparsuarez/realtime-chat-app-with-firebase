import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  const Input({
    super.key,
    this.labelText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value!.isEmpty ? '' : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: labelText,
      ),
    );
  }
}
