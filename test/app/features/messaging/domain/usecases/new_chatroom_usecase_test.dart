import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_users_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MessagingRepository>()])
void main() {
  late MockMessagingRepository mockMessagingRepository;
  late NewChatroomUsecase usecase;

  setUp(
    () {
      mockMessagingRepository = MockMessagingRepository();
      usecase = NewChatroomUsecase(
        mockMessagingRepository,
      );
    },
  );

  final mockModel = ChatRoomModel(
    createdAt: DateTime.now(),
    members: ['', ''],
  );

  group('New Chatroom Usecase', () {
    test('When is success should return chatroomId', () async {
      //Arrange
      when(mockMessagingRepository.newChatRoom(any)).thenAnswer(
        (_) async => Either.right('chatroomId'),
      );

      //Act
      final result = await usecase.call(mockModel);

      //Assert
      expect(result.whenOrNull(right: (id) => id), isA<String>());
      expect(result.whenOrNull(right: (id) => id), 'chatroomId');
    });

    test('Should return failure when throw exception', () async {
      //Arrange
      when(mockMessagingRepository.newChatRoom(any)).thenAnswer(
        (_) async => Either.left(Failure.unknown()),
      );

      //Act
      final result = await usecase.call(mockModel);

      //Assert
      expect(result.whenOrNull(left: (failure) => failure), isA<Failure>());
      expect(result.whenOrNull(left: (failure) => failure), Failure.unknown());
    });
  });
}
