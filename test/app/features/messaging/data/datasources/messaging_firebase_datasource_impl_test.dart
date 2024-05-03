import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/models/user_model.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/data/datasources/messaging_firebase_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'messaging_firebase_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<CollectionReference>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<QueryDocumentSnapshot>(),
  MockSpec<DocumentReference>(),
])
void main() {
  late MessagingFirebaseDatasourceImpl datasource;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late QueryDocumentSnapshot<Map<String, dynamic>> mockQueryDocumentSnapshot;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;

  setUp(
    () {
      mockFirestore = MockFirebaseFirestore();
      mockCollectionReference = MockCollectionReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
      mockDocumentReference = MockDocumentReference();
      datasource = MessagingFirebaseDatasourceImpl(mockFirestore);
    },
  );

  group(
    'Messaging Firebase Datasource Impl',
    () {
      test('listUsers should return Stream with user list', () async {
        //Arrange

        final Map<String, dynamic> data = {
          'name': 'name',
          'lastName': 'lastName',
          'uid': 'uid',
          'email': 'email',
          'isOnline': 0,
        };

        final List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocumentSnapshotList = [
          mockQueryDocumentSnapshot,
        ];

        when(mockFirestore.collection(any)).thenReturn(mockCollectionReference);

        when(mockCollectionReference.snapshots()).thenAnswer(
          (_) => Stream.fromIterable([mockQuerySnapshot]),
        );

        when(mockQuerySnapshot.docs).thenReturn(queryDocumentSnapshotList);

        when(queryDocumentSnapshotList[0].data()).thenAnswer((_) => data);

        //Act

        final stream = datasource.listenUsers();
        final result = await stream.first;

        //Assert
        expect(stream, isA<Stream<List<UserModel>>>());
        expect(result, isA<List<UserModel>>());

        verify(mockCollectionReference.snapshots()).called(1);
      });
    },
  );
}
