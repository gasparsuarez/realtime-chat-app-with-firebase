import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/repositories/repositories.dart';

class NewChatroomUsecase {
  final MessagingRepository _repository;

  NewChatroomUsecase(this._repository);

  Future<Either<Failure, String>> call(ChatRoomModel model) {
    return _repository.newChatRoom(model);
  }
}
