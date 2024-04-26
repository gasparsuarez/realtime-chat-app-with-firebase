import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthRepositoryImpl>()])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late MockAuthRepositoryImpl mockAuthRepositoryImpl;

  final dto = CreateUserDto(
    name: 'name',
    email: 'email',
    password: 'password',
    lastName: 'lastName',
  );

  setUp(
    () {
      mockAuthRepositoryImpl = MockAuthRepositoryImpl();
    },
  );

  group(
    'Auth Repository',
    () {
      test(
        'createUser should return success message',
        () async {
          const successMessage = 'The user has been created successfully';

          //Arrange
          when(mockAuthRepositoryImpl.createUser(any)).thenAnswer(
            (_) async => Either.right(successMessage),
          );

          //Act
          final result = await mockAuthRepositoryImpl.createUser(dto);

          //Assert
          expect(
            result.whenOrNull(right: (message) => message),
            successMessage,
          );
          expect(
            result.whenOrNull(right: (message) => message),
            isA<String>(),
          );
        },
      );

      test(
        'createUser should return AuthFailure',
        () async {
          //Arrange
          final failure = AuthFailure.invalidEmail();

          when(mockAuthRepositoryImpl.createUser(any)).thenAnswer(
            (_) async => Either.left(
              failure,
            ),
          );
          //Act
          final result = await mockAuthRepositoryImpl.createUser(dto);

          //Assert
          expect(
            result.whenOrNull(left: (failure) => failure),
            failure,
          );
          expect(
            result.whenOrNull(left: (failure) => failure),
            isA<AuthFailure>(),
          );
        },
      );

      test(
        'signIn should return user when is success',
        () async {
          //Arrange
          final user = UserEntity(
            uid: 'uid',
            name: 'name',
            email: 'email',
            lastName: 'lastName',
            isOnline: 1,
          );
          when(mockAuthRepositoryImpl.signIn('', '')).thenAnswer(
            (_) async => Either.right(user),
          );
          //Act
          final result = await mockAuthRepositoryImpl.signIn('', '');
          //Assert
          expect(
            result.whenOrNull(right: (user) => user),
            isA<UserEntity>(),
          );
          expect(
            result.whenOrNull(right: (user) => user),
            user,
          );
        },
      );

      test(
        'signIn should return AuthFailure',
        () async {
          //Arrange
          final failure = AuthFailure.userNotFound();
          when(mockAuthRepositoryImpl.signIn('', '')).thenAnswer(
            (_) async => Either.left(failure),
          );
          //Act
          final result = await mockAuthRepositoryImpl.signIn('', '');
          //Assert
          expect(
            result.whenOrNull(left: (failure) => failure),
            isA<AuthFailure>(),
          );
          expect(
            result.whenOrNull(left: (failure) => failure),
            failure,
          );
        },
      );
    },
  );
}
