import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/form_controllers/form_controllers.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final form = RegisterFormBloc();
  @override
  Widget build(BuildContext context) {
    return CustomSliverScaffold(
      title: 'Sign up',
      subtitle: 'Complete with your information',
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
                    height: context.h * 0.04,
                  ),
                  Input(
                    controller: form.nameController,
                    labelText: 'Name',
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  Input(
                    controller: form.lastNameController,
                    labelText: 'Last Name',
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  Input(
                    controller: form.emailController,
                    labelText: 'Email',
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  Input(
                    controller: form.passwordController,
                    labelText: 'Password',
                  ),
                  SizedBox(
                    height: context.h * 0.02,
                  ),
                  Input(
                    controller: form.repPasswordController,
                    labelText: 'Repeat password',
                  ),
                  SizedBox(
                    height: context.h * 0.06,
                  ),
                  Button(
                    onTap: () {
                      //TODO: Signup function
                    },
                    child: const CustomText(
                      text: 'Register',
                    ),
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
