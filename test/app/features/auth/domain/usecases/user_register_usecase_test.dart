import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthRepositoryImpl>()])
import 'user_register_usecase_test.mocks.dart';

void main() {
  late UserRegisterUsecase userRegisterUsecase;
  late MockAuthRepositoryImpl mockRepository;

  setUp(
    () {
      mockRepository = MockAuthRepositoryImpl();
      userRegisterUsecase = UserRegisterUsecase(mockRepository);
    },
  );

  group(
    'User Register Usecase',
    () {
      final dto = UserModel(
        name: 'name',
        email: 'email',
        password: 'password',
        lastName: 'lastName',
      );

      test(
        'when call() is success should return String',
        () async {
          //Arrange
          when(userRegisterUsecase.call(dto)).thenAnswer(
            (_) async => Either.right('Success mock'),
          );
          //Act
          final result = await userRegisterUsecase.call(dto);
          //Assert
          expect(result.whenOrNull(right: (success) => success), isA<String>());
        },
      );

      test(
        'when call() is failure should return AuthFailure',
        () async {
          //Arrange
          when(userRegisterUsecase.call(dto)).thenAnswer(
            (_) async => Either.left(AuthFailure.invalidEmail()),
          );

          //Act
          final result = await userRegisterUsecase.call(dto);

          //Assert
          expect(result.whenOrNull(left: (failure) => failure), isA<AuthFailure>());
        },
      );
    },
  );
}
