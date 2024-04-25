import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/either/my_either.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final instance = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<Either<AuthFailure, String>> createUser(CreateUserDto dto) async {
    try {
      await instance.createUserWithEmailAndPassword(email: dto.email, password: dto.password).then(
        (credential) async {
          final userData = UserEntity(
            uid: credential.user!.uid,
            name: dto.name,
            email: dto.email,
            lastName: dto.lastName,
            isOnline: 1,
          );

          await firestore.collection('users').add(userData.toJson());
        },
      );
      return Either.right('The user has been created successfully');
    } on FirebaseAuthException catch (e) {
      return Either.left(
        parseCodeToFailure(e.code),
      );
    }
  }
}
