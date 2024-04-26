import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

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
          TextButton(
            onPressed: () {},
            child: const Text('Sign Out'),
          )
        ],
        title: const Text(
          'Chat App',
        ),
      ),
    );
  }
}
