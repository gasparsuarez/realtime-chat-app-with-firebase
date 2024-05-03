import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/models/user_model.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/models/chat_room_model.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/models/message_model.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/datasource/datasource.dart';

class MessagingFirebaseDatasourceImpl implements MessagingFirebaseDatasource {
  final FirebaseFirestore _firestore;

  /// Dependency Injection
  MessagingFirebaseDatasourceImpl(this._firestore);

  @override
  Stream<List<UserModel>> listenUsers() {
    final users = _firestore.collection('users').snapshots().map(
          (querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromJson(e.data())).toList(),
        );
    return users;
  }

  @override
  Future<String> newChatRoom(ChatRoomModel model) async {
    late String chatRoomId;

    await _firestore
        .collection('chatRooms/${model.from}_${model.to}/chat_detail')
        .add(model.toJson())
        .then((doc) async {
      await doc.update({'chatroomId': doc.id});
      chatRoomId = doc.id;
    });
    return chatRoomId;
  }

  @override
  Future<void> sendMessage(MessageModel model) async {
    await _firestore
        .collection('chatRooms/${model.from}_${model.to}/messages')
        .add(model.toJson())
        .then((doc) async {
      await doc.update({'messageId': doc.id});
    });
  }
}
