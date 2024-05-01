import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize ?? context.w * 0.04,
        color: textColor ?? Colors.white,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
