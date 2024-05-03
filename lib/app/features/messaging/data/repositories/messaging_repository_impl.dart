import 'package:firebase_realtime_chat_app/app/core/either/my_either.dart';
import 'package:firebase_realtime_chat_app/app/core/network/exception_handler.dart';
import 'package:firebase_realtime_chat_app/app/core/network/failures/failure.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/models/message_model.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/datasource/datasource.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/repositories/repositories.dart';

class MessagingRepositoryImpl implements MessagingRepository {
  final MessagingFirebaseDatasource _datasource;

  // Dependency Injection
  MessagingRepositoryImpl(this._datasource);

  @override
  Stream<List<UserEntity>> listenUsers() {
    final mappedStream = _datasource.listenUsers().map(
          (event) => event.map((e) => UserModel.modelToUser(e)).toList(),
        );

    return mappedStream;
  }

  @override
  Future<Either<Failure, bool>> sendMessage(MessageModel model) async {
    try {
      await _datasource.sendMessage(model);
      return Either.right(true);
    } on Exception catch (e) {
      return Either.left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Stream<List<MessageEntity>> listenChatMessages(String chatroomId) {
    final mappedStream = _datasource.listenChatMessages(chatroomId).map(
          (event) => event
              .map(
                (e) => MessageModel.toEntity(e),
              )
              .toList(),
        );

    return mappedStream;
  }
}
