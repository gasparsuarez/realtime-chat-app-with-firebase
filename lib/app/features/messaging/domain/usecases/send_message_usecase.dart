import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';

class SendMessageUsecase {
  final MessagingRepository _repository;

  SendMessageUsecase(this._repository);

  Future<Either<Failure, bool>> call(MessageModel model) {
    return _repository.sendMessage(model);
  }
}
