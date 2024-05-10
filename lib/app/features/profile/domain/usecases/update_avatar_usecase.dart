import 'dart:io';

import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';

class UpdateAvatarUsecase {
  final UserProfileRepository _repository;

  UpdateAvatarUsecase(this._repository);

  Future<Either<Failure, String>> call(File file) {
    return _repository.updateAvatar(file);
  }
}
