import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAvatarCircle extends StatelessWidget {
  final UserEntity user;
  final double size;
  const UserAvatarCircle({
    super.key,
    required this.user,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          width: context.w * size,
          height: context.w * size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: kPrimaryColor,
            ),
          ),
          child: user.imageUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: user.imageUrl!,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: context.w * 0.02,
                      height: context.w * 0.02,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                )
              : Image.asset(
                  'assets/images/user_avatar.png',
                ),
        );
      },
    );
  }
}
