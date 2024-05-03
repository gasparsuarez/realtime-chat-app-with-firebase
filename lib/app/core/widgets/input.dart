import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool filled;
  final bool validate;
  const Input({
    super.key,
    this.labelText,
    this.controller,
    this.obscureText,
    this.filled = false,
    this.validate = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validate ? (value) => value!.isEmpty ? '' : null : null,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: labelText,
        fillColor: filled ? Colors.white : null,
        filled: filled,
      ),
    );
  }
}
