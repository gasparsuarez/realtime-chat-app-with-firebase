import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';

abstract class MessagingRepository {
  Stream<List<UserEntity>> listenUsers();
  Future<Either<Failure, bool>> sendMessage(MessageModel model);
  Stream<List<MessageEntity>> listenChatMessages(String chatroomId);
}
