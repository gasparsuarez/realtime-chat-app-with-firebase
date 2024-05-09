import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/data/models/models.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, String>> updateProfile(UpdateProfileModel model);
}
