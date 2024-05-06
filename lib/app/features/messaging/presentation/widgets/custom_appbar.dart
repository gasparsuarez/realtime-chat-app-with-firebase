import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.user != null) {
          final user = state.user!;
          return SizedBox(
            width: context.w,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        context.w * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(
                          context.w * 0.030,
                        ),
                      ),
                      child: Row(
                        children: [
                          UserAvatarCircle(
                            user: user,
                            size: 0.12,
                          ),
                          SizedBox(
                            width: context.w * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: user.fullName,
                                fontSize: context.w * 0.048,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const _PopupMenu(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

enum _PopupButtonTypes {
  profile,
  exit,
}

class _PopupMenu extends StatefulWidget {
  const _PopupMenu();

  @override
  State<_PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<_PopupMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return PopupMenuButton(
          iconColor: Colors.white,
          onSelected: (value) {
            switch (value) {
              case _PopupButtonTypes.exit:
                context.read<AuthCubit>().signOut();
                break;
              case _PopupButtonTypes.profile:
                //TODO: Go profile
                break;
              default:
                null;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: _PopupButtonTypes.profile,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: context.w * 0.04,
                  ),
                  SizedBox(
                    width: context.w * 0.02,
                  ),
                  const Text(
                    'Profile',
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: _PopupButtonTypes.exit,
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    size: context.w * 0.04,
                  ),
                  SizedBox(
                    width: context.w * 0.02,
                  ),
                  const Text(
                    'Exit',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
