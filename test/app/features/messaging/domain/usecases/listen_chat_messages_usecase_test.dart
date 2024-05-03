import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_users_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MessagingRepository>(),
])
void main() {
  late ListenChatMessagesUsecase usecase;
  late MockMessagingRepository mockMessagingRepository;

  setUp(() {
    mockMessagingRepository = MockMessagingRepository();
    usecase = ListenChatMessagesUsecase(
      mockMessagingRepository,
    );
  });

  group('Listen Chat Messages Usecase', () {
    test('Should return stream with List of messages', () async {
      //Arrange

      final mockList = [
        MessageEntity(
          messageId: 'messageId',
          createdAt: DateTime.now(),
          from: '',
          to: 'to',
          content: 'content',
        )
      ];

      when(mockMessagingRepository.listenChatMessages(any)).thenAnswer(
        (_) => Stream.fromIterable([mockList]),
      );
      //Act

      final stream = usecase.call('');
      final result = await stream.first;

      //Assert
      expect(stream, isA<Stream<List<MessageEntity>>>());
      expect(result, isA<List<MessageEntity>>());
      expect(result.first.messageId, 'messageId');
    });
  });
}
