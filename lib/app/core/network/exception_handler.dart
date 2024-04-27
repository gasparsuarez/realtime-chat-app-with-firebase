import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';

///
/// Exception Handler
///
/// This return custom Failure for handle responses
///
class ExceptionHandler {
  ExceptionHandler._();

  static Failure handleException(Exception e) {
    switch (e) {
      case FirebaseAuthException(code: final code):
        return Failure.auth(code);
      case SocketException():
        return Failure.network();
      default:
        return Failure.unknown();
    }
  }
}
