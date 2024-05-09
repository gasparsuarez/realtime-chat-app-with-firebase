import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<ProfileFirebaseDatasource>(),
])
import 'user_profile_repository_impl_test.mocks.dart';

void main() {
  late UserProfileRepositoryImpl repository;
  late MockProfileFirebaseDatasource mockProfileFirebaseDatasource;

  setUp(() {
    mockProfileFirebaseDatasource = MockProfileFirebaseDatasource();
    repository = UserProfileRepositoryImpl(
      mockProfileFirebaseDatasource,
    );
  });

  group(
    'User Profile Repository Impl',
    () {
      final model = UpdateProfileModel(
        name: 'name',
        lastName: 'lastName',
      );

      test('updateProfile() should return String when is success', () async {
        //Arrange
        when(mockProfileFirebaseDatasource.updateProfile(any))
            .thenAnswer((_) async => Future<void>);

        //Act
        final result = await repository.updateProfile(model);

        //Assert
        final value = result.whenOrNull(right: (success) => success);
        expect(value, isA<String>());
        expect(value, 'Profile has been updated');
      });

      test('updateProfile() should return failure', () async {
        //Arrange
        when(mockProfileFirebaseDatasource.updateProfile(any))
            .thenThrow(Exception('Error has been occurred'));

        //Act
        final result = await repository.updateProfile(model);

        //Assert
        final value = result.whenOrNull(left: (failure) => failure);
        expect(value, isA<Failure>());
        expect(value, Failure.unknown(message: 'Error has been occurred!'));
      });
    },
  );
}
