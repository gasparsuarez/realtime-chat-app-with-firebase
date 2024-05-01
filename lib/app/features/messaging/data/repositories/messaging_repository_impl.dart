import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/datasource/datasource.dart';
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
}
