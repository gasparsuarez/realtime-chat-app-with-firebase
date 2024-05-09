import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/data/models/update_profile_model.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/datasources/datasources.dart';

class ProfileFirebaseDatasourceImpl implements ProfileFirebaseDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  // Dependency Injection
  ProfileFirebaseDatasourceImpl(
    this._firestore,
    this._auth,
  );

  @override
  Future<void> updateProfile(UpdateProfileModel model) async {
    final ref = _firestore.collection('users').doc(_auth.currentUser?.uid);

    /// Update user data
    await ref.update(model.toJson());
  }
}
