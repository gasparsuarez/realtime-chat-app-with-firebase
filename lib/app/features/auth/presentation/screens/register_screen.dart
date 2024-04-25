import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/form_controllers/form_controllers.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
    return BlocProvider(
      create: (_) => RegisterUserCubit(sl()),
      child: CustomSliverScaffold(
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
                    BlocConsumer<RegisterUserCubit, RegisterUserState>(
                      listener: (context, state) {
                        switch (state) {
                          case Loaded(message: final message):
                            AlertUtil.showAlert(
                              context,
                              title: 'Success',
                              description: message,
                            );
                            break;
                          case Error(message: final message):
                            AlertUtil.showAlert(
                              context,
                              title: 'Error',
                              description: message,
                              type: ToastificationType.error,
                            );
                          default:
                        }
                      },
                      builder: (context, state) {
                        return Button(
                          onTap: (state is Loading)
                              ? () => null
                              : () {
                                  /// Validate forms
                                  final validationMessage = form.validateForm();
                                  if (validationMessage != null) {
                                    AlertUtil.showAlert(
                                      context,
                                      title: 'Error',
                                      description: validationMessage,
                                      type: ToastificationType.error,
                                    );
                                    return;
                                  }

                                  /// Send DTO for execute register
                                  context.read<RegisterUserCubit>().register(form.userDto);
                                },
                          child: const CustomText(
                            text: 'Register',
                          ),
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
