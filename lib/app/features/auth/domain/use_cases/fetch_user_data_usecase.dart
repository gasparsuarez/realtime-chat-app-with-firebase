import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class FetchUserDataUsecase {
  final AuthRepository _repository;

  FetchUserDataUsecase(this._repository);

  Future<Either<Failure, UserEntity>> call() {
    return _repository.fetchUserData();
  }
}
