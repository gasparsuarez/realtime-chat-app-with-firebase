import 'package:firebase_realtime_chat_app/app/core/either/my_either.dart';
import 'package:firebase_realtime_chat_app/app/core/network/failures/failure.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final ProfileFirebaseDatasource _datasource;

  UserProfileRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, String>> updateProfile(UpdateProfileModel model) async {
    try {
      await _datasource.updateProfile(model);
      return Either.right('Profile has been updated');
    } on Exception catch (e) {
      return Either.left(Failure.unknown(message: 'Error has been occurred!'));
    }
  }
}
