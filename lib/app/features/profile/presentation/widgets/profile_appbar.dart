import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: context.h * 0.02),
              height: context.w * 0.36,
              width: context.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: kPrimaryColor,
                  width: context.w * 0.014,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
          Positioned(
            top: context.h * 0.2,
            left: context.w * 0.56,
            child: Container(
              margin: EdgeInsets.only(top: context.h * 0.02),
              height: context.w * 0.08,
              width: context.w * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: kPrimaryColor,
                  width: context.w * 0.014,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Icon(
                Icons.edit,
                size: context.w * 0.048,
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
