import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<UserProfileRepository>(),
])
import 'update_profile_usecase_test.mocks.dart';

void main() {
  late UpdateProfileUsecase usecase;
  late MockUserProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockUserProfileRepository();
    usecase = UpdateProfileUsecase(
      mockRepository,
    );
  });

  group(
    'Update Profile Usecase',
    () {
      final model = UpdateProfileModel(
        name: 'name',
        lastName: 'lastName',
      );

      test('Should return String when is successfuly', () async {
        //Arrange
        when(mockRepository.updateProfile(any)).thenAnswer((_) async => Either.right(''));

        //Act
        final result = await usecase.call(model);

        //Assert
        final value = result.whenOrNull(right: (success) => success);
        expect(value, isA<String>());
      });

      test('Should return failure when throws exception', () async {
        //Arrange
        when(mockRepository.updateProfile(any))
            .thenAnswer((_) async => Either.left(Failure.unknown()));

        //Act
        final result = await usecase.call(model);

        //Assert
        final value = result.whenOrNull(left: (failure) => failure);
        expect(value, isA<Failure>());
      });
    },
  );
}
