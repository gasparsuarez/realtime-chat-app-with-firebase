import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Update Profile Model',
    () {
      test('Should create a valid model', () async {
        //Assert
        final model = UpdateProfileModel(
          name: 'name',
          lastName: 'lastName',
        );
        expect(model, isA<UpdateProfileModel>());
        expect(model.name, 'name');
        expect(model.lastName, 'lastName');
      });

      test('Should create a valid JSON', () async {
        final model = UpdateProfileModel(
          name: 'name',
          lastName: 'lastName',
        );

        final json = model.toJson();

        //Assert
        expect(json, isMap);
        expect(json['name'], 'name');
        expect(json['lastName'], 'lastName');
      });
    },
  );
}
