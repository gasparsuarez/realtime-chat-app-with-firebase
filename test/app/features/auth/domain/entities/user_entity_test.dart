import 'package:firebase_realtime_chat_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'User entity',
    () {
      test(
        'Should be create a valid user',
        () async {
          final user = UserEntity(
            uid: 'uid',
            name: 'name',
            email: 'email',
            lastName: 'lastName',
            isOnline: 1,
          );

          expect(user, isA<UserEntity>());
          expect(user.uid, 'uid');
          expect(user.name, 'name');
          expect(user.email, 'email');
          expect(user.lastName, 'lastName');
          expect(user.isOnline, 1);
        },
      );
    },
  );
}
