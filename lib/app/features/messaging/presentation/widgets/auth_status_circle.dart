import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';

class AuthStatusCircle extends StatelessWidget {
  final bool isOnline;
  final double size;

  ///
  /// Show circle container with auth status of user
  ///
  /// Green = Online
  ///
  /// Grey = Offline
  ///
  const AuthStatusCircle({
    super.key,
    required this.isOnline,
    this.size = 0.024,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w * size,
      height: context.w * size,
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
