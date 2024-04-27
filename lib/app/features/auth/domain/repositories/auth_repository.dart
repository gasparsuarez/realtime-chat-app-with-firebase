import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/models/user_model.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> createUser(UserModel model);
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, bool>> signOut();
  Stream<User?> listenAuthentication();
}
