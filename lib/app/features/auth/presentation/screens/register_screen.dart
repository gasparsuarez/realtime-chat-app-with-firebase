import 'package:firebase_realtime_chat_app/app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String routeName = 'register_screen';
  @override
  Widget build(BuildContext context) {
    return CustomSliverScaffold(
      title: 'Register',
      subtitle: 'Complete with your information',
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
