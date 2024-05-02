import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final UserEntity user;
  const ChatView({
    super.key,
    required this.user,
  });

  static const String routeName = 'chat_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
        ),
      ),
    );
  }
}
