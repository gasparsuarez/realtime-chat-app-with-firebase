import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';

class ListenChatMessagesUsecase {
  final MessagingRepository _repository;

  ListenChatMessagesUsecase(this._repository);
  Stream<List<MessageEntity>> call(String chatroomId) {
    return _repository.listenChatMessages(chatroomId);
  }
}
