import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserEntity>> updateProfile();
}
