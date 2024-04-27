import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class UserSignoutUsecase {
  final AuthRepository _repository;

  UserSignoutUsecase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.signOut();
  }
}
