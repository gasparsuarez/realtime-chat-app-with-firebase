import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseStorage>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
  MockSpec<Reference>(),
  MockSpec<UploadTask>(),
  MockSpec<TaskSnapshot>(),
])
import 'profile_firebase_datasource_impl_test.mocks.dart';

void main() {
  late ProfileFirebaseDatasourceImpl datasource;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseStorage mockFirebaseStorage;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late MockReference mockReference;
  late MockUploadTask mockUploadTask;
  late MockTaskSnapshot mockTaskSnapshot;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockFirebaseStorage = MockFirebaseStorage();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockUploadTask = MockUploadTask();
    mockReference = MockReference();
    mockTaskSnapshot = MockTaskSnapshot();

    datasource = ProfileFirebaseDatasourceImpl(
      mockFirebaseFirestore,
      mockFirebaseAuth,
      mockFirebaseStorage,
    );
  });

  group(
    'Profile Firebase Datasource Impl',
    () {
      test('updateProfile() should update user information', () async {
        //Arrange

        final model = UpdateProfileModel(
          name: 'name',
          lastName: 'lastName',
        );

        when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);

        when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);

        when(mockDocumentReference.update(any)).thenAnswer((_) async => Future<void>);

        //Act
        await datasource.updateProfile(model);

        //Assert

        verify(mockFirebaseFirestore.collection('users')).called(1);

        verify(mockDocumentReference.update(model.toJson())).called(1);
      });

      test('updateAvatar() should update user image and save data to firestore', () async {
        //Arrange
        when(mockFirebaseStorage.ref(any)).thenReturn(mockReference);

        when(mockReference.child('avatars/null/null.')).thenReturn(mockReference);

        when(mockReference.putFile(any)).thenAnswer((_) => mockUploadTask);

        when(mockUploadTask.snapshot).thenReturn(mockTaskSnapshot);

        when(mockTaskSnapshot.ref).thenReturn(mockReference);

        when(mockReference.getDownloadURL()).thenAnswer((_) => Future.value(''));

        when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);

        when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);

        when(mockDocumentReference.update(any)).thenAnswer((_) async => Future);

        //Act
        await datasource.updateAvatar(File(''));

        //Assert
        verify(mockFirebaseStorage.ref(any)).called(1);
        verify(mockReference.child('avatars/null/null.')).called(1);
        verify(mockReference.getDownloadURL()).called(1);
        verify(mockDocumentReference.update(any)).called(1);
      });
    },
  );
}
