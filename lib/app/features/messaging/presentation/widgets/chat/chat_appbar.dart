import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final UserEntity user;
  const ChatAppBar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          UserAvatarCircle(
            user: user,
            size: 0.10,
          ),
          SizedBox(
            width: context.w * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomText(
                    text: user.fullName,
                    fontSize: context.w * 0.04,
                  ),
                  SizedBox(
                    width: context.w * 0.02,
                  ),
                  AuthStatusCircle(
                    isOnline: user.isOnlineUser,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
