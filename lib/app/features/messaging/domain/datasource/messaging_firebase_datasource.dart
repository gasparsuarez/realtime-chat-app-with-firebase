import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/data.dart';

abstract class MessagingFirebaseDatasource {
  Stream<List<UserModel>> listenUsers();
  Future<void> sendMessage(MessageModel model);
}
