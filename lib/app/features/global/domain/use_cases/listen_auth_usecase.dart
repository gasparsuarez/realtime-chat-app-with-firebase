import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/global/domain/domain.dart';

class ListenAuthUsecase {
  final AuthStateRepository _authStateRepository;

  ListenAuthUsecase(this._authStateRepository);

  Stream<User?> call() {
    return _authStateRepository.listenAuthentication();
  }
}
