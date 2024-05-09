import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';

class UpdateProfileUsecase {
  final UserProfileRepository _repository;

  UpdateProfileUsecase(this._repository);

  Future<Either<Failure, String>> call(UpdateProfileModel model) {
    return _repository.updateProfile(model);
  }
}
