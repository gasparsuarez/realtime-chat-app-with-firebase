import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/form_controllers/login_form_bloc.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/signin_user/signin_user_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (_) => SigninUserCubit(sl()),
      child: CustomSliverScaffold(
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
                    Input(
                      controller: form.emailController,
                      labelText: 'Email',
                    ),
                    SizedBox(
                      height: context.h * 0.02,
                    ),
                    Input(
                      controller: form.passController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: context.h * 0.06,
                    ),
                    BlocConsumer<SigninUserCubit, SigninUserState>(
                      listener: (context, state) {
                        switch (state) {
                          case Loaded(user: final user):
                            AlertUtil(context).showAlert(
                              title: 'Welcome!',
                              description: 'Welcome to my app ${user.name}',
                            );
                          case Error(message: final message):
                            AlertUtil(context).showAlert(
                              title: 'Error',
                              description: message,
                              type: ToastificationType.error,
                            );
                            break;
                          default:
                        }
                      },
                      builder: (context, state) {
                        return Button(
                          onTap: state is Loading
                              ? () => null
                              : () {
                                  final validationMessage = form.validateForm();
                                  if (validationMessage != null) {
                                    return AlertUtil(context).showAlert(
                                      title: 'Error',
                                      description: validationMessage,
                                      type: ToastificationType.error,
                                    );
                                  }
                                  context.read<SigninUserCubit>().signIn(
                                        form.emailController.text,
                                        form.passController.text,
                                      );
                                },
                          child: const CustomText(text: 'Login'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            childCount: 1,
          ),
        ),
      ),
    );
  }
}
