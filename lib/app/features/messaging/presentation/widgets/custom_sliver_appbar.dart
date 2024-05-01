import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({super.key});

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
                      child: Row(
                        children: [
                          Container(
                            width: context.w * 0.12,
                            height: context.w * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green,
                              ),
                            ),
                            child: Center(
                              child: CustomText(
                                text: user.name[0].toUpperCase(),
                                textColor: kBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: context.w * 0.06,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: context.w * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: '${user.name} ${user.lastName}',
                                fontSize: context.w * 0.06,
                                textColor: kBlackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const Spacer(),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () => context.read<AuthCubit>().signOut(),
                                icon: Icon(
                                  Icons.exit_to_app,
                                  color: kBlackColor,
                                ),
                              );
                            },
                          )
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
