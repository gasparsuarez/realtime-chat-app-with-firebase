import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthRepositoryImpl>()])
import 'user_signin_usecase_test.mocks.dart';

void main() {
  late UserSigninUsecase userSigninUsecase;
  late MockAuthRepositoryImpl repository;

  setUp(
    () {
      repository = MockAuthRepositoryImpl();
      userSigninUsecase = UserSigninUsecase(repository);
    },
  );
  group(
    'User SignIn Usecase',
    () {
      test('should return true', () async {
        //Arrange
        when(repository.signIn('', '')).thenAnswer(
          (_) async => Either.right(true),
        );

        //Act
        final result = await userSigninUsecase.call('', '');

        //Assert
        expect(
          result.whenOrNull(right: (value) => value),
          isA<bool>(),
        );
        expect(
          result.whenOrNull(right: (value) => value),
          isTrue,
        );
      });

      test(
        'should return Failure',
        () async {
          //Arrange
          final failure = Failure.auth('');
          when(repository.signIn('', '')).thenAnswer(
            (_) async => Either.left(failure),
          );
          //Act
          final result = await userSigninUsecase.call('', '');

          //Assert
          expect(
            result.whenOrNull(left: (failure) => failure),
            isA<Failure>(),
          );
          expect(
            result.whenOrNull(left: (failure) => failure),
            Failure.auth(''),
          );
        },
      );
    },
  );
}
