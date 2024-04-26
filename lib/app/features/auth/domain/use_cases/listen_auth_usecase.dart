import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class ListenAuthUsecase {
  final AuthRepository _authRepository;

  ListenAuthUsecase(this._authRepository);

  Stream<User?> call() {
    return _authRepository.listenAuthentication();
  }
}
