import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
])
import 'profile_firebase_datasource_impl_test.mocks.dart';

void main() {
  late ProfileFirebaseDatasourceImpl datasource;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    datasource = ProfileFirebaseDatasourceImpl(
      mockFirebaseFirestore,
      mockFirebaseAuth,
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
    },
  );
}
