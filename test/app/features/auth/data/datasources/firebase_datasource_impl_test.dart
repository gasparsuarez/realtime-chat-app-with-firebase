import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(
  [
    MockSpec<FirebaseAuth>(),
    MockSpec<FirebaseFirestore>(),
    MockSpec<UserCredential>(),
    MockSpec<DocumentReference<Map<String, dynamic>>>(),
    MockSpec<CollectionReference>(),
    MockSpec<DocumentSnapshot>(),
    MockSpec<User>(),
  ],
)
import 'firebase_datasource_impl_test.mocks.dart';

void main() {
  late FirebaseDatasourceImpl firebaseDatasourceImpl;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential userCredential;
  late MockDocumentReference mockDocumentReference;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  late MockUser mockUser;

  setUp(
    () {
      userCredential = MockUserCredential();
      mockDocumentReference = MockDocumentReference();
      mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
      mockFirebaseAuth = MockFirebaseAuth();
      mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
      mockUser = MockUser();

      mockFirebaseFirestore = MockFirebaseFirestore();
      firebaseDatasourceImpl = FirebaseDatasourceImpl(
        mockFirebaseFirestore,
        mockFirebaseAuth,
      );
    },
  );

  group(
    'Firebase Datasource Impl',
    () {
      test('createUser should create user and save data to firestore', () async {
        // arrange

        final userModel = UserModel(
          name: 'name',
          email: 'email',
          lastName: 'lastName',
          password: 'password',
        );

        when(mockFirebaseAuth.createUserWithEmailAndPassword(email: 'email', password: 'password'))
            .thenAnswer((_) => Future.value(userCredential));

        when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);

        when(mockCollectionReference.doc(userCredential.user?.uid))
            .thenReturn(mockDocumentReference);

        // act
        await firebaseDatasourceImpl.createUser(userModel);

        // assert

        verify(
            mockFirebaseAuth.createUserWithEmailAndPassword(email: 'email', password: 'password'));
      });

      test('signIn should return User Model', () async {
        //Arrange
        when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'email', password: 'password'))
            .thenAnswer(
          (_) => Future.value(userCredential),
        );

        when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);

        when(mockCollectionReference.doc(userCredential.user?.uid))
            .thenReturn(mockDocumentReference);

        when(mockDocumentReference.update({'isOnline': ''})).thenAnswer((_) async => Future<void>);

        when(mockDocumentReference.get()).thenAnswer(
          (_) async => Future.value(mockDocumentSnapshot),
        );
        final Map<String, dynamic> mockUserData = {
          'name': 'name',
          'lastName': 'lastName',
          'email': 'email',
          'uid': 'uid',
          'isOnline': 0,
        };
        when(mockDocumentSnapshot.data()).thenReturn(mockUserData);

        //Act
        final result = await firebaseDatasourceImpl.signIn('email', 'password');

        //Assert
        verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'email', password: 'password'));
        expect(result, isA<UserModel>());
      });

      test('signOut should logout user', () async {
        //Arrange
        when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);

        when(mockCollectionReference.doc(userCredential.user?.uid))
            .thenReturn(mockDocumentReference);

        when(mockDocumentReference.update({'isOnline': 0})).thenAnswer(
          (_) async => Future<void>,
        );

        when(mockFirebaseAuth.signOut()).thenAnswer((_) async => Future<void>);
        //Act
        await firebaseDatasourceImpl.signOut();

        //Assert
        verify(mockFirebaseAuth.signOut());
      });

      test('listenAuthentication should listen auth status', () async {
        //Arrange
        when(mockFirebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.fromIterable([mockUser]),
        );

        //Act
        final stream = firebaseDatasourceImpl.listenAuthentication();
        final user = await stream.first;
        //Assert
        verify(mockFirebaseAuth.authStateChanges());
        expect(stream, isA<Stream>());
        expect(user, isA<MockUser>());
      });
    },
  );
}
