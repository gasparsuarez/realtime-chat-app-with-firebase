import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/global/domain/repositories/auth_state_repository.dart';

class AuthStateRepositoryImpl implements AuthStateRepository {
  final instance = FirebaseAuth.instance;

  @override
  Stream<User?> listenAuthentication() {
    return instance.authStateChanges();
  }
}
