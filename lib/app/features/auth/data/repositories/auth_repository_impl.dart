import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/core/network/exception_handler.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  // Dependency Injection
  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, String>> createUser(UserModel model) async {
    try {
      await _datasource.createUser(model);
      return Either.right('The user has been created successfully');
    } on Exception catch (e) {
      return Either.left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final userModel = await _datasource.signIn(email, password);
      final userEntity = UserModel.modelToUser(userModel);
      return Either.right(userEntity);
    } on Exception catch (e) {
      return Either.left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await _datasource.signOut();
      return Either.right(true);
    } on Exception catch (e) {
      return Either.left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Stream<User?> listenAuthentication() => _datasource.listenAuthentication();
}
