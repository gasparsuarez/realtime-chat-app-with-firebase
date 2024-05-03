import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: context.w * 0.8),
          decoration: BoxDecoration(
            border: Border.all(
              color: kBlackColor,
            ),
          ),
          margin: EdgeInsets.symmetric(
            vertical: context.h * 0.008,
            horizontal: context.w * 0.02,
          ),
          padding: EdgeInsets.symmetric(
            vertical: context.h * 0.008,
            horizontal: context.w * 0.02,
          ),
          child: const Text(
            'Hello, how are you ?',
          ),
        ),
      ],
    );
  }
}
