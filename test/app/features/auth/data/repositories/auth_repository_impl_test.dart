import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseDatasourceImpl>(),
  MockSpec<User>(),
])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockFirebaseDatasourceImpl datasource;

  final model = UserModel(
    name: 'name',
    email: 'email',
    password: 'password',
    lastName: 'lastName',
  );

  setUp(
    () {
      datasource = MockFirebaseDatasourceImpl();
      authRepositoryImpl = AuthRepositoryImpl(datasource);
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
          when(authRepositoryImpl.createUser(model)).thenAnswer(
            (_) async => Either.right(successMessage),
          );

          //Act
          final result = await authRepositoryImpl.createUser(model);

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
        'createUser should return Failure',
        () async {
          //Arrange
          final failure = Failure.auth('invalid-email');

          when(datasource.createUser(model))
              .thenThrow(FirebaseAuthException(code: 'invalid-email'));
          //Act
          final result = await authRepositoryImpl.createUser(model);

          //Assert
          expect(
            result.whenOrNull(left: (failure) => failure),
            failure,
          );
          expect(
            result.whenOrNull(left: (failure) => failure),
            isA<Failure>(),
          );
        },
      );

      test(
        'signIn should return user when is success',
        () async {
          //Arrange
          final user = UserModel(
            uid: 'uid',
            name: 'name',
            email: 'email',
            lastName: 'lastName',
            isOnline: 1,
          );

          when(datasource.signIn('', '')).thenAnswer(
            (_) async => user,
          );

          //Act
          final result = await authRepositoryImpl.signIn('', '');
          //Assert
          expect(
            result.whenOrNull(right: (user) => user),
            isA<UserEntity>(),
          );
        },
      );

      test(
        'signIn should return Failure when throw Exception',
        () async {
          //Arrange
          when(datasource.signIn('', '')).thenThrow(FirebaseAuthException(code: ''));

          //Act
          final result = await authRepositoryImpl.signIn('', '');

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

      test(
        'signOut should return true',
        () async {
          // Arrange
          when(authRepositoryImpl.signOut()).thenAnswer(
            (_) async => Either.right(true),
          );

          // Act
          final result = await authRepositoryImpl.signOut();

          // Expect
          expect(result.whenOrNull(right: (value) => value), true);
        },
      );
      test(
        'signOut should return Failure when throw Exception',
        () async {
          // Arrange
          when(datasource.signOut()).thenThrow(FirebaseAuthException(code: 'invalid-email'));

          // Act
          final result = await authRepositoryImpl.signOut();

          // Expect
          final resultFailure = result.whenOrNull(left: (failure) => failure);
          expect(resultFailure, Failure.auth('invalid-email'));
          expect(resultFailure, isA<Failure>());
        },
      );

      test(
        'listenAuthentication should Stream user',
        () async {
          //Arrange
          when(datasource.listenAuthentication()).thenAnswer(
            (_) => Stream.fromIterable([MockUser()]),
          );
          //Act
          final stream = authRepositoryImpl.listenAuthentication();
          final result = await stream.first;
          //Assert
          expect(stream, isA<Stream>());
          expect(result, isA<MockUser>());
        },
      );
    },
  );
}
