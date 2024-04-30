import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  static const String routeName = 'messaging_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.brown,
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                child: CustomText(
                  text: 'Logout',
                  textColor: kBlackColor,
                  fontSize: context.w * .04,
                ),
              );
            },
          )
        ],
        title: CustomText(
          text: 'ChatApp',
          fontSize: context.w * .06,
        ),
      ),
    );
  }
}
