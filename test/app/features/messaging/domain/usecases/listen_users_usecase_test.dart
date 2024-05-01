import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_users_usecase_test.mocks.dart';

@GenerateNiceMocks(
  [MockSpec<MessagingRepository>()],
)
void main() {
  late ListenUsersUsecase usecase;
  late MockMessagingRepository mockMessagingRepository;

  setUp(
    () {
      mockMessagingRepository = MockMessagingRepository();
      usecase = ListenUsersUsecase(
        mockMessagingRepository,
      );
    },
  );

  group('Listen Users Usecase', () {
    test(
      'Should return Stream with list of user entities',
      () async {
        // Arrange

        final userList = [
          UserEntity(
            uid: 'uid',
            name: 'name',
            email: 'email',
            lastName: 'lastName',
            isOnline: 1,
          ),
        ];

        when(mockMessagingRepository.listenUsers()).thenAnswer(
          (_) => Stream.fromIterable([userList]),
        );
        // Act
        final stream = usecase.call();
        final result = await stream.first;

        // Assert
        expect(stream, isA<Stream<List<UserEntity>>>());
        expect(result, isA<List<UserEntity>>());
      },
    );
  });
}
