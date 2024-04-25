import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/global/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/global/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthStateRepositoryImpl>()])
import 'listen_auth_usecase_test.mocks.dart';

void main() {
  late ListenAuthUsecase listenAuthUsecase;
  late MockAuthStateRepositoryImpl mockRepository;

  setUp(
    () {
      mockRepository = MockAuthStateRepositoryImpl();
      listenAuthUsecase = ListenAuthUsecase(mockRepository);
    },
  );

  group(
    'Listen Auth Usecase',
    () {
      test(
        'call should return Stream with optional user',
        () async {
          //Arrange
          when(listenAuthUsecase.call()).thenAnswer(
            (_) => Stream.fromIterable(<User?>[]),
          );

          //Act
          final result = listenAuthUsecase.call();

          //Assert
          expect(result, isA<Stream<User?>>());
        },
      );
    },
  );
}
