import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'messaging_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MessagingFirebaseDatasourceImpl>(),
])
void main() {
  late MessagingRepositoryImpl messagingRepositoryImpl;
  late MockMessagingFirebaseDatasourceImpl mockMessagingFirebaseDatasourceImpl;

  setUp(
    () {
      mockMessagingFirebaseDatasourceImpl = MockMessagingFirebaseDatasourceImpl();
      messagingRepositoryImpl = MessagingRepositoryImpl(
        mockMessagingFirebaseDatasourceImpl,
      );
    },
  );

  final mockModel = MessageModel(
    createdAt: DateTime(2024, 05, 5),
    from: 'from',
    to: 'to',
    content: 'content',
  );

  group('Messaging Repository Impl', () {
    test(
      'listenUsers should return Stream with List of UserEntity',
      () async {
        // Arrange

        final mockList = [
          UserModel(
            name: 'name',
            email: 'email',
            lastName: 'lastName',
            isOnline: 1,
            uid: '',
          ),
        ];

        when(mockMessagingFirebaseDatasourceImpl.listenUsers()).thenAnswer(
          (_) => Stream.fromIterable([mockList]),
        );
        // Act

        final stream = messagingRepositoryImpl.listenUsers();
        final result = await stream.first;

        // Assert
        expect(stream, isA<Stream<List<UserEntity>>>());
        expect(result, isA<List<UserEntity>>());
      },
    );

    test('sendMessage should return true when is success', () async {
      //Arrange
      when(mockMessagingFirebaseDatasourceImpl.sendMessage(any))
          .thenAnswer((_) async => Future<void>);

      //Act
      final result = await messagingRepositoryImpl.sendMessage(mockModel);

      //Assert
      expect(result.whenOrNull(right: (success) => success), true);
    });

    test('sendMessage should return Failure when throw exception', () async {
      //Arrange
      when(mockMessagingFirebaseDatasourceImpl.sendMessage(any))
          .thenThrow(FirebaseException(plugin: 'plugin'));

      //Act
      final result = await messagingRepositoryImpl.sendMessage(mockModel);

      //Assert
      expect(result.whenOrNull(left: (failure) => failure), isA<Failure>());
    });
  });
}
