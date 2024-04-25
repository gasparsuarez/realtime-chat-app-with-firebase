import 'package:firebase_realtime_chat_app/app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login_screen';

  @override
  Widget build(BuildContext context) {
    return CustomSliverScaffold(
      title: 'Login',
      subtitle: 'Enter email and password',
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            children: [],
          ),
          childCount: 1,
        ),
      ),
    );
  }
}
