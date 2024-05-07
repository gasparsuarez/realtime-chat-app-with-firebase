import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_cubit/auth_cubit.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          final user = state.user!;
          return Scaffold(
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.w * 0.08,
                        ),
                        child: Column(
                          children: [
                            Input(
                              labelText: 'First name',
                              initialValue: user.name,
                              filled: true,
                            ),
                            SizedBox(
                              height: context.h * 0.02,
                            ),
                            Input(
                              labelText: 'Last name',
                              initialValue: user.lastName,
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
                            Button(
                              onTap: () {},
                              child: const CustomText(
                                text: 'Update Profile',
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
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
