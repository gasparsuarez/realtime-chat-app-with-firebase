import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  // Dependency Injection
  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<AuthFailure, String>> createUser(UserModel model) async {
    try {
      await _datasource.createUser(model);
      return Either.right('The user has been created successfully');
    } on FirebaseAuthException catch (e) {
      return Either.left(
        parseCodeToFailure(e.code),
      );
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signIn(String email, String password) async {
    try {
      final userModel = await _datasource.signIn(email, password);
      final userEntity = UserModel.modelToUser(userModel);
      return Either.right(userEntity);
    } on FirebaseAuthException catch (e) {
      return Either.left(
        parseCodeToFailure(e.code),
      );
    }
  }

  @override
  Future<Either<AuthFailure, bool>> signOut() async {
    try {
      await _datasource.signOut();
      return Either.right(true);
    } catch (e) {
      return Either.left(AuthFailure.unknown());
    }
  }
}
