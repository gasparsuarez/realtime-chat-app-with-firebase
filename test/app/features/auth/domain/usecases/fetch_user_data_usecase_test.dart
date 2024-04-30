import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/repositories/repositories.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_register_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepositoryImpl>(),
])
void main() {
  late FetchUserDataUsecase usecase;
  late MockAuthRepositoryImpl mockRepository;

  setUp(() {
    mockRepository = MockAuthRepositoryImpl();
    usecase = FetchUserDataUsecase(
      mockRepository,
    );
  });

  group(
    'Fetch User Data Usecase',
    () {
      test('Should return User Entity', () async {
        //Arrange

        final user = UserEntity(
          uid: 'uid',
          name: 'name',
          email: 'email',
          lastName: 'lastName',
          isOnline: 1,
        );
        when(mockRepository.fetchUserData()).thenAnswer(
          (_) async => Either.right(user),
        );
        //Act
        final result = await usecase.call();

        //Assert
        expect(
          result.whenOrNull(
            right: (user) => user,
          ),
          isA<UserEntity>(),
        );
      });

      test('Should return Failure when exception is occurred', () async {
        //Arrange

        when(mockRepository.fetchUserData()).thenAnswer(
          (_) async => Either.left(
            Failure.unknown(),
          ),
        );
        //Act
        final result = await usecase.call();

        //Assert
        expect(
          result.whenOrNull(
            left: (failure) => failure,
          ),
          isA<Failure>(),
        );
      });
    },
  );
}
