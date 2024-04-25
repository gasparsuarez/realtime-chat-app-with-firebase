import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

///
/// Show Alert
///
/// Toastification Types: Info, success, error, warning
///
class AlertUtil {
  static showAlert(
    BuildContext context, {
    required String title,
    required String description,
    ToastificationType? type,
  }) {
    return toastification.show(
      context: context,
      type: type ?? ToastificationType.success,
      autoCloseDuration: const Duration(
        seconds: 5,
      ),
      title: CustomText(
        text: title,
        textColor: kBlackColor,
      ),
      description: CustomText(
        text: description,
        textColor: kBlackColor,
      ),
    );
  }
}
