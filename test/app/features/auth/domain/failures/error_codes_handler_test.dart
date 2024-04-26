import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Error codes handler',
    () {
      test(
        'should return AuthFailure',
        () {
          final failure = parseAuthCodeToFailure('invalid-email');
          expect(failure, isA<AuthFailure>());
          expect(failure, AuthFailure.invalidEmail());
        },
      );

      test(
        'Should return AuthFailures for known error codes',
        () {
          // Arrange
          final errorCodes = [
            'email-already-in-use',
            'wrong-password',
            'invalid-email',
            'user-not-found',
            'invalid-credential',
          ];

          for (var code in errorCodes) {
            final failure = parseAuthCodeToFailure(code);
            expect(failure, isA<AuthFailure>());
          }
        },
      );
    },
  );
}
