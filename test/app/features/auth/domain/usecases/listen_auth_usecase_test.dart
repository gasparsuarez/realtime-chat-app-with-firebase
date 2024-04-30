import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<User>(),
])
import 'listen_auth_usecase_test.mocks.dart';

void main() {
  late ListenAuthUsecase usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = ListenAuthUsecase(mockRepository);
  });

  group(
    'Listen Auth Usecase',
    () {
      test(
        'call() should Stream User',
        () async {
          // Arrange
          when(mockRepository.listenAuthentication()).thenAnswer(
            (_) => Stream.fromIterable([MockUser()]),
          );

          // Act
          final stream = usecase.call();
          final first = await stream.first;

          // Expect
          expect(stream, isA<Stream>());
          expect(first, isA<User>());
        },
      );
    },
  );
}
