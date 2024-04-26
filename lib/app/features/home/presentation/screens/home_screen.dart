import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () => context.read<AuthCubit>().signOut(),
                child: const Text('Sign Out'),
              );
            },
          )
        ],
        title: const Text(
          'Chat App',
        ),
      ),
    );
  }
}
