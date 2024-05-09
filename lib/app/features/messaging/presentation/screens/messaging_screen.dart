import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/widgets/messaging_appbar.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/widgets/user_list_builder.dart';
import 'package:flutter/material.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  static const String routeName = 'messaging_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  const MessagingAppbar(),
                  SizedBox(
                    height: context.w * 0.02,
                  ),
                  const UserListBuilder(),
                ],
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
