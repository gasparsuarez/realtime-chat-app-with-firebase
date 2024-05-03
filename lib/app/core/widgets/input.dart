import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? filled;
  const Input({
    super.key,
    this.labelText,
    this.controller,
    this.obscureText,
    this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value!.isEmpty ? '' : null,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: labelText,
        fillColor: filled! ? Colors.white : null,
        filled: filled,
      ),
    );
  }
}
