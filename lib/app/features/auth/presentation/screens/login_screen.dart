import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/form_controllers/login_form_bloc.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form = LoginFormBloc();

  @override
  Widget build(BuildContext context) {
    return CustomSliverScaffold(
      title: 'Login',
      subtitle: 'Enter email and password',
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.12,
            ),
            child: Form(
              key: form.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: context.h * 0.2,
                  ),
                  const Input(
                    labelText: 'Email',
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  const Input(
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: context.h * 0.06,
                  ),
                  Button(
                    onTap: () {
                      final validationMessage = form.validateForm();
                      if (validationMessage != null) {
                        return AlertUtil(context).showAlert(
                          title: 'Error',
                          description: validationMessage,
                          type: ToastificationType.error,
                        );
                      }
                    },
                    child: const CustomText(text: 'Login'),
                  ),
                ],
              ),
            ),
          ),
          childCount: 1,
        ),
      ),
    );
  }
}
