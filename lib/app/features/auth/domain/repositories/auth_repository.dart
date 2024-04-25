import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, String>> createUser(CreateUserDto dto);
  Future<Either<AuthFailure, UserEntity?>> signIn(String email, String password);
}
