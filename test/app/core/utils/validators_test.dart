import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validEmail = 'valid@email.com';

  group(
    'Email Validator',
    () {
      test(
        'Should return true when is valid email',
        () {
          expect(Validators.validateEmail(validEmail), true);
        },
      );
      test(
        'Should return false when is not valid email',
        () {
          expect(Validators.validateEmail('not-valid-email'), false);
        },
      );
    },
  );
}
