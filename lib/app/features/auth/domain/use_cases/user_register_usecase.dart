import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/models/user_model.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class UserRegisterUsecase {
  final AuthRepository _authRepository;

  UserRegisterUsecase(this._authRepository);

  Future<Either<AuthFailure, String>> call(UserModel model) {
    return _authRepository.createUser(model);
  }
}
