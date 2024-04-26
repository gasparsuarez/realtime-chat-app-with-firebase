import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';

abstract class AuthDatasource {
  Future<void> createUser(UserModel model);
  Future<UserModel> signIn(String email, String password);
  Future<void> signOut();
  Stream<User?> listenAuthentication();
}
