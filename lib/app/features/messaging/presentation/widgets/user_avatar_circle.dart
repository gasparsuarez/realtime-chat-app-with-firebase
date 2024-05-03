import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter/material.dart';

class UserAvatarCircle extends StatelessWidget {
  final UserEntity user;
  final double size;
  const UserAvatarCircle({
    super.key,
    required this.user,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w * size,
      height: context.w * size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: kPrimaryColor,
        ),
      ),
      child: Center(
        child: CustomText(
          text: user.name[0].toUpperCase(),
          textColor: kBlackColor,
          fontWeight: FontWeight.bold,
          fontSize: context.w * 0.04,
        ),
      ),
    );
  }
}
