import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'User Model',
    () {
      test(
        'Should be create valid User Model',
        () {
          final model = UserModel(
            name: 'name',
            email: 'email',
            lastName: 'lastName',
          );
          expect(model, isA<UserModel>());
          expect(model.name, 'name');
          expect(model.lastName, 'lastName');
          expect(model.email, 'email');
          expect(model.uid, null);
          expect(model.password, null);
        },
      );

      test(
        'fromJson should return User Model',
        () {
          final Map<String, dynamic> mockJson = {
            'uid': 'uid',
            'isOnline': 0,
            'name': 'name',
            'email': 'email',
            'lastName': 'lastName',
          };

          final model = UserModel.fromJson(mockJson);

          expect(model, isA<UserModel>());
          expect(model.name, 'name');
          expect(model.lastName, 'lastName');
          expect(model.email, 'email');
          expect(model.uid, 'uid');
          expect(model.isOnline, 0);
        },
      );

      test(
        'toJson should return a valid Json',
        () {
          final userModel = UserModel(
            uid: 'uid',
            name: 'name',
            email: 'email',
            lastName: 'lastName',
            isOnline: 1,
          );

          final jsonData = userModel.toJson();

          expect(jsonData, isA<Map<String, dynamic>>());
          expect(jsonData['uid'], 'uid');
          expect(jsonData['name'], 'name');
          expect(jsonData['lastName'], 'lastName');
          expect(jsonData['email'], 'email');
          expect(jsonData['isOnline'], 1);
        },
      );
    },
  );
}
