import 'dart:io';

import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/repositories/repositories.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/usecases/usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<UserProfileRepository>(),
])
import 'update_avatar_usecase_test.mocks.dart';

void main() {
  late MockUserProfileRepository mockRepository;
  late UpdateAvatarUsecase usecase;

  setUp(() {
    mockRepository = MockUserProfileRepository();
    usecase = UpdateAvatarUsecase(mockRepository);
  });

  group(
    'Update Avatar Usecase',
    () {
      test('Should return String when is success', () async {
        //Arrange
        when(mockRepository.updateAvatar(any)).thenAnswer(
          (_) async => Either.right(''),
        );

        //Act
        final result = await usecase.call(File(''));

        //Assert
        final resultValue = result.whenOrNull(right: (success) => success);
        expect(result, isA<Right>());
        expect(resultValue, isA<String>());
      });
      test('Should return Failure when throws Exception', () async {
        //Arrange
        when(mockRepository.updateAvatar(any)).thenAnswer(
          (_) async => Either.left(Failure.unknown()),
        );

        //Act
        final result = await usecase.call(File(''));

        //Assert
        final resultValue = result.whenOrNull(left: (failure) => failure);
        expect(result, isA<Left>());
        expect(resultValue, isA<Failure>());
      });
    },
  );
}
