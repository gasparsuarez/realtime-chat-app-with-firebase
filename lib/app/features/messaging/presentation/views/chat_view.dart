import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final UserEntity user;
  const ChatView({
    super.key,
    required this.user,
  });

  static const String routeName = 'chat_view';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scroll,
              physics: const ClampingScrollPhysics(),
              slivers: [
                ChatAppBar(
                  user: widget.user,
                ),
                SliverList.builder(
                  itemCount: 200,
                  itemBuilder: (context, index) => const MessageBubble(),
                )
              ],
            ),
          ),
          Container(
            width: context.w,
            padding: const EdgeInsets.all(6),
            color: kPrimaryColor,
            child: Center(
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Input(
                          labelText: 'Enter message',
                          filled: true,
                        ),
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {},
                        icon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
