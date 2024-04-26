import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
])
import 'user_signout_usecase_test.mocks.dart';

void main() {
  late UserSignoutUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(
    () {
      mockRepository = MockAuthRepository();
      usecase = UserSignoutUsecase(mockRepository);
    },
  );

  test(
    'should return true when is success',
    () async {
      // arrange
      when(usecase.call()).thenAnswer(
        (_) async => Either.right(true),
      );

      // act
      final result = await usecase.call();

      // expect
      expect(result.whenOrNull(right: (value) => value), true);
    },
  );

  test(
    'should return AuthFailure when is failure',
    () async {
      // arrange
      when(usecase.call()).thenAnswer(
        (_) async => Either.left(AuthFailure.unknown()),
      );

      // act
      final result = await usecase.call();

      // expect
      expect(result.whenOrNull(left: (failure) => failure), isA<AuthFailure>());
    },
  );
}
