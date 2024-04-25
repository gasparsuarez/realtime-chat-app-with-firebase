import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class UserRegisterUsecase {
  final AuthRepository _authRepository;

  UserRegisterUsecase(this._authRepository);

  Future<Either<AuthFailure, String>> call(CreateUserDto dto) {
    return _authRepository.createUser(dto);
  }
}
