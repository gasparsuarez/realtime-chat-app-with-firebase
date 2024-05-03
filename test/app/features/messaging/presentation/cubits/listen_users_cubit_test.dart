import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_users_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ListenUsersUsecase>(),
])
void main() {
  late MockListenUsersUsecase mockListenUsersUsecase;
  late ListenUsersCubit listenUsersCubit;

  setUp(
    () {
      mockListenUsersUsecase = MockListenUsersUsecase();
      listenUsersCubit = ListenUsersCubit(
        mockListenUsersUsecase,
      );
    },
  );

  final userList = [
    UserEntity(
      uid: 'uid',
      name: 'name',
      email: 'email',
      lastName: 'lastName',
      isOnline: 1,
    ),
  ];

  group('Listen Users Cubit', () {
    test('Initial state should be initial()', () async {
      expect(listenUsersCubit.state, const ListenUsersState.initial());
    });

    blocTest<ListenUsersCubit, ListenUsersState>(
      'emits [Loading, Loaded] when listenUsers is called.',
      build: () {
        when(mockListenUsersUsecase.call()).thenAnswer(
          (_) => Stream.fromIterable([userList]),
        );
        return listenUsersCubit;
      },
      act: (cubit) => cubit.listenUsers(),
      expect: () => [
        const ListenUsersState.loading(),
        ListenUsersState.loaded(users: userList),
      ],
    );
  });
}
