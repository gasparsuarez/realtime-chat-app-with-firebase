import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class AlertUtil {
  final BuildContext context;

  AlertUtil(this.context);

  ///
  /// Show Alert
  ///
  /// Toastification Types: Info, success, error, warning
  ///
  showAlert({
    required String title,
    required String description,
    ToastificationType? type,
  }) {
    return toastification.show(
      context: context,
      type: type ?? ToastificationType.success,
      autoCloseDuration: const Duration(
        seconds: 4,
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

  ///
  /// Show dialog with circular progress indicator
  ///
  showLoader() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: context.h * 0.1,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void hideAlert() => context.pop();
}
