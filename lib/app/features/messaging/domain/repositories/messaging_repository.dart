import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

abstract class MessagingRepository {
  Stream<List<UserEntity>> listenUsers();
}
