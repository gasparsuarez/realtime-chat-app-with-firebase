import 'package:firebase_realtime_chat_app/app/core/either/my_either.dart';
import 'package:firebase_realtime_chat_app/app/core/network/failures/failure.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final ProfileFirebaseDatasource _datasource;

  UserProfileRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UpdateProfileModel model) {
    throw UnimplementedError();
  }
}
