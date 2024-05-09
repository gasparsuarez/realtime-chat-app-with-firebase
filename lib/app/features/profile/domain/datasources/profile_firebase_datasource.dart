import 'package:firebase_realtime_chat_app/app/features/profile/data/models/models.dart';

abstract class ProfileFirebaseDatasource {
  Future<void> updateProfile(UpdateProfileModel model);
}
