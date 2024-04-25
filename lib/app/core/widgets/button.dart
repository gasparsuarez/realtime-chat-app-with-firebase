import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onTap;
  final double? width;
  final double? height;
  final Widget child;
  const Button({
    super.key,
    required this.onTap,
    this.width,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.w * 0.4,
      height: height ?? context.h * 0.06,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: kShadowColor,
            blurStyle: BlurStyle.solid,
            offset: const Offset(
              0,
              2,
            ),
            blurRadius: 4,
          )
        ],
        borderRadius: BorderRadius.circular(
          context.w * 0.026,
        ),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
