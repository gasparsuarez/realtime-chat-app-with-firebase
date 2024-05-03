import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            case Loaded(users: final usersList):
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.02,
                ),
                child: SizedBox(
                  height: context.h * 0.6,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      /// Remove actual user data for the list
                      final newUserList = [...usersList]..removeWhere(
                          (currentUser) => currentUser.uid == state.user?.uid,
                        );

                      return ListView.builder(
                        itemCount: newUserList.length,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final user = newUserList[index];
                          return _UserTile(
                            user: user,
                          );
                        },
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

///
/// Tile with User data
///
class _UserTile extends StatelessWidget {
  final UserEntity user;
  const _UserTile({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: IconButton(
          onPressed: () => context.pushNamed(
            ChatView.routeName,
            extra: user,
          ),
          icon: Icon(
            Icons.message_outlined,
            color: kPrimaryColor,
          ),
        ),
        title: Row(
          children: [
            CustomText(
              text: user.fullName,
              textColor: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              width: context.w * 0.02,
            ),
            AuthStatusCircle(
              isOnline: user.isOnlineUser,
            )
          ],
        ),
        subtitle: CustomText(
          text: user.email,
          textColor: kPrimaryColor,
        ),
        leading: UserAvatarCircle(
          size: 0.10,
          user: user,
        ),
      ),
    );
  }
}
