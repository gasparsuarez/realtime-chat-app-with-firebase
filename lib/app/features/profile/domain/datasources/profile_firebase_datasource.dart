import 'package:firebase_realtime_chat_app/app/features/auth/data/models/models.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/data/models/models.dart';

abstract class ProfileFirebaseDatasource {
  Future<UserModel> updateProfile(UpdateProfileModel model);
}
