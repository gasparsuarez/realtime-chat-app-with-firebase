import 'dart:developer';

import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/bloc/cubit/update_profile_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/bloc/form_bloc/profile_form_bloc.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../auth/presentation/bloc/auth_cubit/auth_cubit.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  static const String routeName = 'profile';

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final formBloc = ProfileFormBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          final user = state.user!;
          return BlocProvider(
            create: (_) => UpdateProfileCubit(sl()),
            child: Scaffold(
              backgroundColor: kBackgroundColor,
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: ProfileAppbar(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Form(
                        key: formBloc.formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.w * 0.08,
                          ),
                          child: Column(
                            children: [
                              Input(
                                controller: formBloc.firstNameController..text = user.name,
                                labelText: 'First name',
                                filled: true,
                              ),
                              SizedBox(
                                height: context.h * 0.02,
                              ),
                              Input(
                                controller: formBloc.lastNameController..text = user.lastName,
                                labelText: 'Last name',
                                filled: true,
                              ),
                              SizedBox(
                                height: context.h * 0.02,
                              ),
                              Input(
                                labelText: 'Email address',
                                initialValue: user.email,
                                filled: true,
                                isReadOnly: true,
                              ),
                              SizedBox(
                                height: context.h * 0.02,
                              ),
                              BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                                listener: (context, state) {
                                  switch (state) {
                                    case Updated(message: final message):
                                      AlertUtil(context).showAlert(
                                          title: 'Success',
                                          description: message,
                                          type: ToastificationType.success);
                                      context.read<AuthCubit>().fetchUserData();
                                    case UpdateError(message: final message):
                                      AlertUtil(context).showAlert(
                                        title: 'Error',
                                        description: message,
                                        type: ToastificationType.error,
                                      );
                                  }
                                },
                                builder: (context, state) => state is Updating
                                    ? const CircularProgressIndicator()
                                    : Button(
                                        onTap: () {
                                          if (formBloc.formKey.currentState!.validate()) {
                                            context
                                                .read<UpdateProfileCubit>()
                                                .updateProfile(formBloc.updateModel);
                                          }
                                        },
                                        child: const CustomText(
                                          text: 'Update Profile',
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
