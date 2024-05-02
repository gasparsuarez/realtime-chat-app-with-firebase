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

    test('newChatRoom should return chatroomId', () async {
      //Arrange
      when(mockMessagingFirebaseDatasourceImpl.newChatRoom(any)).thenAnswer(
        (_) async => Future.value('chatroomId'),
      );
      //Act
      final result = await messagingRepositoryImpl.newChatRoom(
        ChatRoomModel(createdAt: DateTime.now(), members: ['', '']),
      );
      //Assert

      expect(result.whenOrNull(right: (id) => id), isA<String>());
      expect(result.whenOrNull(right: (id) => id), 'chatroomId');
    });

    test('newChatRoom should return chatroomId', () async {
      //Arrange
      when(mockMessagingFirebaseDatasourceImpl.newChatRoom(any))
          .thenThrow(Exception('Exception has been occurred'));

      //Act
      final result = await messagingRepositoryImpl.newChatRoom(
        ChatRoomModel(createdAt: DateTime.now(), members: ['', '']),
      );

      //Assert
      expect(result.whenOrNull(left: (failure) => failure), isA<Failure>());
      expect(result.whenOrNull(left: (failure) => failure), Failure.unknown());
    });
  });
}
