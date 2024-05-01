import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';

class ListenUsersUsecase {
  final MessagingRepository _repository;

  ListenUsersUsecase(this._repository);

  Stream<List<UserEntity>> call() {
    return _repository.listenUsers();
  }
}
