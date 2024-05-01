import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/models/user_model.dart';
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
}
