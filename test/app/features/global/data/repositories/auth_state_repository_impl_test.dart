import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/global/data/repositories/auth_state_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<AuthStateRepositoryImpl>(),
  MockSpec<User>(),
])
import 'auth_state_repository_impl_test.mocks.dart';

void main() {
  late MockAuthStateRepositoryImpl mockRepository;
  late MockUser mockUser;
  setUp(
    () {
      mockUser = MockUser();
      mockRepository = MockAuthStateRepositoryImpl();
    },
  );
  group(
    'Auth State Repository',
    () {
      test(
        'Listen method should return Stream with optional User',
        () async {
          // arrange
          when(mockRepository.listenAuthentication()).thenAnswer(
            (_) => Stream.fromIterable([mockUser]),
          );

          // act
          final result = mockRepository.listenAuthentication();
          final user = await result.first;
          // asserts
          expect(result, isA<Stream<User?>>());
          expect(mockUser, user);
        },
      );
    },
  );
}
