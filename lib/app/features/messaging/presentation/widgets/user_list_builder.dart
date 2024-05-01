import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/blocs/cubit/listen_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBuilder extends StatelessWidget {
  const UserListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListenUsersCubit(sl())..listenUsers(),
      child: BlocBuilder<ListenUsersCubit, ListenUsersState>(
        builder: (context, state) {
          switch (state) {
            case Loading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Loaded(users: final users):
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.02,
                ),
                child: SizedBox(
                  height: context.h * 0.6,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w * 0.02,
                      vertical: context.w * 0.02,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: context.h * 0.02,
                      crossAxisSpacing: context.w * 0.02,
                      mainAxisExtent: context.h * 0.12,
                    ),
                    itemCount: users.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            context.w * 0.04,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(context.w * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: context.w * 0.10,
                                    height: context.w * 0.10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: kPrimaryColor,
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
                                  const Spacer(),
                                  Container(
                                    width: context.w * 0.026,
                                    height: context.w * 0.026,
                                    decoration: BoxDecoration(
                                      color: user.isOnlineUser ? Colors.green : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: CustomText(
                                  text: '${user.name} ${user.lastName}ASDASDASDASDASDA',
                                  textColor: kBlackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            case Error(message: final message):
              return Center(
                child: Text(message!),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
