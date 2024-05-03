import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/cubits/form_bloc/chat_bloc.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/cubits/send_message/send_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final chatBloc = ChatBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SendMessageCubit(sl()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
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
                        itemCount: 4,
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
                            Expanded(
                              child: Input(
                                controller: chatBloc.messageInputController,
                                labelText: 'Enter message',
                                filled: true,
                                validate: false,
                              ),
                            ),
                            BlocConsumer<SendMessageCubit, SendMessageState>(
                              listener: (context, state) {
                                switch (state) {
                                  case Sent():
                                    AlertUtil(context).showAlert(
                                      title: 'Éxito!',
                                      description: 'Mensaje enviado',
                                    );
                                  case _:
                                }
                              },
                              builder: (context, state) {
                                return IconButton.filled(
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: state is Sending
                                      ? null
                                      : () {
                                          if (chatBloc.messageInputController.text.isEmpty) return;
                                          final message = MessageModel(
                                            createdAt: DateTime.now(),
                                            from: authState.user!.uid,
                                            to: widget.user.uid,
                                            content: chatBloc.messageInputController.text,
                                          );

                                          context.read<SendMessageCubit>().sendMessage(message);

                                          chatBloc.messageInputController.clear();
                                        },
                                  icon: Icon(
                                    Icons.send,
                                    color: kPrimaryColor,
                                  ),
                                );
                              },
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
        },
      ),
    );
  }
}
