import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/data.dart';

abstract class MessagingRepository {
  Stream<List<UserEntity>> listenUsers();
  Future<Either<Failure, String>> newChatRoom(ChatRoomModel model);
}
