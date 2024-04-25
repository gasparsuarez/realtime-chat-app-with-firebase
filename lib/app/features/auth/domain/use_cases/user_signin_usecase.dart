import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class UserSigninUsecase {
  final AuthRepository _repository;

  UserSigninUsecase(this._repository);

  Future<Either<AuthFailure, UserEntity?>> call(String email, String password) {
    return _repository.signIn(email, password);
  }
}
