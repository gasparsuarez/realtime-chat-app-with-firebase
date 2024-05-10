import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/bloc/update_avatar/update_avatar_cubit.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UpdateAvatarCubit(sl()),
      child: SizedBox(
        height: context.h * 0.36,
        child: Stack(
          children: [
            ClipPath(
              clipper: AppbarClipper(),
              child: Container(
                height: context.h * 0.24,
                width: context.w,
                color: kPrimaryColor,
              ),
            ),

            ///
            /// User Avatar
            ///
            SafeArea(
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state.user != null) {
                    final user = state.user!;
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: context.h * 0.02,
                        ),
                        width: context.w * 0.4,
                        height: context.w * 0.32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: kBlackColor,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: context.w * 0.008),
                        ),
                        child: user.imageUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: user.imageUrl!,
                                progressIndicatorBuilder: (context, url, progress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  );
                                },
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/user_avatar.png',
                              ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            ///
            /// Edit button
            ///
            Positioned(
              top: context.h * 0.22,
              left: context.w * 0.58,
              child: Container(
                margin: EdgeInsets.only(top: context.h * 0.02),
                height: context.w * 0.06,
                width: context.w * 0.06,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: context.w * 0.014,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                child: BlocConsumer<UpdateAvatarCubit, UpdateAvatarState>(
                  listener: (context, state) {
                    switch (state) {
                      case UpdatedAvatar(message: final message):
                        AlertUtil(context).showAlert(
                          title: 'Success',
                          description: message!,
                        );

                        /// Fetch data
                        context.read<AuthCubit>().fetchUserData();
                        break;
                      case UpdateAvatarError(message: final message):
                        AlertUtil(context).showAlert(
                          title: 'Error',
                          description: message!,
                          type: ToastificationType.error,
                        );
                        break;
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => _changeAvatarSourceDialog(
                        context,
                        onSelected: (file) {
                          if (file == null) return;

                          context.read<UpdateAvatarCubit>().updateAvatar(file);
                        },
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: context.w * 0.054,
                      ),
                    );
                  },
                ),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Open modal for select Camera or photo library
  ///
  _changeAvatarSourceDialog(
    BuildContext context, {
    required Function(File? file) onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: context.w,
          height: context.h * 0.16,
          margin: EdgeInsets.all(context.w * 0.06),
          child: SafeArea(
            child: Column(
              children: [
                SelectAvatarSourceButton(
                  label: 'Select from photo library',
                  icon: Icons.photo_album_outlined,
                  onSelect: (file) {
                    onSelected(file);
                    context.pop();
                  },
                ),
                SelectAvatarSourceButton(
                  label: 'Take photo',
                  icon: Icons.camera_alt_outlined,
                  fromGallery: false,
                  onSelect: (file) {
                    onSelected(file);
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height);
    path.quadraticBezierTo(width / 4, height - 70, width, height - 80);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
