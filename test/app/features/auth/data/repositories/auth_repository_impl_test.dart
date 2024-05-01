import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<AuthFirebaseDatasourceImpl>(),
  MockSpec<User>(),
])
import 'auth_repository_impl_test.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthFirebaseDatasourceImpl datasource;

  final model = UserModel(
    name: 'name',
    email: 'email',
    password: 'password',
    lastName: 'lastName',
  );

  setUp(
    () {
      datasource = MockAuthFirebaseDatasourceImpl();
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
          when(datasource.createUser(model)).thenAnswer(
            (_) async => Future<void>,
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
        'signIn should return true when is success',
        () async {
          //Arrange

          when(datasource.signIn('', '')).thenAnswer(
            (_) async => Future,
          );

          //Act
          final result = await authRepositoryImpl.signIn('', '');
          //Assert
          expect(
            result.whenOrNull(right: (value) => value),
            isA<bool>(),
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
          when(datasource.signOut()).thenAnswer(
            (_) async => Future,
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

      test('FetchUserData should return UserData', () async {
        //Arrange
        final user = UserModel(
            name: 'name',
            email: 'email',
            password: 'password',
            lastName: 'lastName',
            isOnline: 1,
            uid: '');

        when(datasource.fetchUserData()).thenAnswer((_) async => Future.value(user));

        //Act
        final result = await authRepositoryImpl.fetchUserData();

        //Assert
        expect(
          result.whenOrNull(right: (user) => user),
          isA<UserEntity>(),
        );
      });

      test('FetchUserData should return Failure', () async {
        //Arrange
        when(datasource.fetchUserData()).thenThrow(FirebaseException(plugin: ''));

        //Act
        final result = await authRepositoryImpl.fetchUserData();

        //Assert
        expect(
          result.whenOrNull(left: (failure) => failure),
          isA<Failure>(),
        );
      });
    },
  );
}
