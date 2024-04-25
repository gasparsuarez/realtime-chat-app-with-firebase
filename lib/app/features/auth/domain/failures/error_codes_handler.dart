import 'package:firebase_realtime_chat_app/app/features/auth/domain/failures/auth_failure.dart';

AuthFailure parseCodeToFailure(String code) {
  switch (code) {
    case 'email-already-in-use':
      return AuthFailure.emailAlreadyUsed();
    case 'wrong-password':
      return AuthFailure.wrongPassword();
    case 'invalid-email':
      return AuthFailure.wrongPassword();
    default:
      return AuthFailure.unknown();
  }
}
