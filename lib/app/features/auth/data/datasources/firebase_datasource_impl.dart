import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/models/user_model.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';

class FirebaseDatasourceImpl implements AuthDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  // Dependency injection
  FirebaseDatasourceImpl(this._firestore, this._auth);

  @override
  Future<void> createUser(UserModel model) async {
    await _auth.createUserWithEmailAndPassword(email: model.email, password: model.password!).then(
      (credential) async {
        final userData = UserModel(
          uid: credential.user!.uid,
          name: model.name,
          email: model.email,
          lastName: model.lastName,
          isOnline: 1,
        );

        await _firestore.collection('users').doc(credential.user!.uid).set(userData.toJson());
      },
    );
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    late UserModel user;
    await _auth.signInWithEmailAndPassword(email: email, password: password).then(
      (credential) async {
        // Update online status

        final ref = _firestore.collection('users').doc(credential.user!.uid);
        await ref.update({
          'isOnline': 1,
        });

        //Get user information
        final snapshot = await ref.get();
        user = UserModel.fromJson(snapshot.data()!);
      },
    );
    return user;
  }

  @override
  Future<void> signOut() async {
    final uid = _auth.currentUser!.uid;
    await _firestore.collection('users').doc(uid).update({'isOnline': 0}).then(
      (_) async => await _auth.signOut(),
    );
  }
}
