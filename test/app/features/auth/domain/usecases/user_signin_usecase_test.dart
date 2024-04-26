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
      test('should return user', () async {
        //Arrange
        final user = UserEntity(
          uid: 'uid',
          name: 'name',
          email: 'email',
          lastName: 'lastName',
          isOnline: 1,
        );

        when(userSigninUsecase.call('', '')).thenAnswer(
          (_) async => Either.right(user),
        );
        //Act
        final result = await userSigninUsecase.call('', '');
        //Assert
        expect(
          result.whenOrNull(right: (user) => user),
          isA<UserEntity>(),
        );
        expect(
          result.whenOrNull(right: (user) => user),
          user,
        );
      });

      test(
        'should return AuthFailure',
        () async {
          //Arrange
          final failure = AuthFailure.userNotFound();
          when(userSigninUsecase.call('', '')).thenAnswer(
            (_) async => Either.left(failure),
          );
          //Act
          final result = await userSigninUsecase.call('', '');

          //Assert
          expect(
            result.whenOrNull(left: (failure) => failure),
            isA<AuthFailure>(),
          );
          expect(
            result.whenOrNull(left: (failure) => failure),
            AuthFailure.userNotFound(),
          );
        },
      );
    },
  );
}
