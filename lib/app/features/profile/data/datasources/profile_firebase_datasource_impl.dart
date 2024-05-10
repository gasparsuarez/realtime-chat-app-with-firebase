import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/data/models/update_profile_model.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/datasources/datasources.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileFirebaseDatasourceImpl implements ProfileFirebaseDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  // Dependency Injection
  ProfileFirebaseDatasourceImpl(this._firestore, this._auth, this._storage);

  @override
  Future<void> updateProfile(UpdateProfileModel model) async {
    final ref = _firestore.collection('users').doc(_auth.currentUser?.uid);

    /// Update user data
    await ref.update(model.toJson());
  }

  @override
  Future<void> updateAvatar(File file) async {
    final currentUserId = _auth.currentUser?.uid;
    final storageRef = _storage.ref();

    // Take file extension
    final fileExtension = file.path.split('/').last.split('.').last;

    // create file path reference
    final avatarRef = storageRef.child('avatars/$currentUserId/$currentUserId.$fileExtension');

    // Save Image
    final uploadTask = avatarRef.putFile(file);

    final downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();

    // Collection of user data
    final userRef = _firestore.collection('users').doc(currentUserId);

    // Update image property
    await userRef.update({'imageUrl': downloadUrl});
  }
}
