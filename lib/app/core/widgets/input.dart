import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool filled;
  final bool validate;
  final bool isReadOnly;
  final String? initialValue;
  final TextAlign? textAlign;
  const Input({
    super.key,
    this.labelText,
    this.controller,
    this.obscureText,
    this.filled = false,
    this.validate = true,
    this.isReadOnly = false,
    this.initialValue,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      textAlign: textAlign ?? TextAlign.start,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validate ? (value) => value!.isEmpty ? '' : null : null,
      obscureText: obscureText ?? false,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        labelText: labelText,
        fillColor: filled ? Colors.white : null,
        filled: filled,
      ),
    );
  }
}
