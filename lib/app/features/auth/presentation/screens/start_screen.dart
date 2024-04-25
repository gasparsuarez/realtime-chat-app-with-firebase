import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  static const String routeName = 'start_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.04,
                  vertical: context.h * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Welcome',
                          textColor: kBlackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: context.w * 0.08,
                        ),
                        CustomText(
                          text: 'Login or register to access chat',
                          textColor: kBlackColor,
                          fontSize: context.w * 0.04,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: context.h * 0.26,
                    ),
                    Button(
                      onTap: () => context.pushNamed(LoginScreen.routeName),
                      height: context.h * 0.046,
                      child: const CustomText(
                        text: 'Login',
                      ),
                    ),
                    SizedBox(
                      height: context.h * 0.04,
                    ),
                    Button(
                      onTap: () => context.pushNamed(RegisterScreen.routeName),
                      height: context.h * 0.046,
                      child: const CustomText(
                        text: 'Register',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
