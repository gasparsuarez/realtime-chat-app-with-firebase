import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;
  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final bool sendMe = message.from == state.user!.uid;
        return Row(
          mainAxisAlignment: sendMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: context.w * 0.8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kBlackColor,
                ),
                borderRadius: sendMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(
                          context.w * 0.02,
                        ),
                        bottomLeft: Radius.circular(
                          context.w * 0.02,
                        ),
                        topRight: Radius.circular(
                          context.w * 0.02,
                        ),
                      )
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(
                          context.w * 0.02,
                        ),
                        bottomRight: Radius.circular(
                          context.w * 0.02,
                        ),
                        topRight: Radius.circular(
                          context.w * 0.02,
                        ),
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
              child: Column(
                crossAxisAlignment: sendMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: message.content,
                    textColor: kBlackColor,
                  ),
                  CustomText(
                    text: _formatTime(message.createdAt),
                    textColor: kBlackColor,
                    fontSize: context.w * 0.028,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat.jm().format(time).toString();
  }
}
