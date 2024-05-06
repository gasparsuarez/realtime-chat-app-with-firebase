import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<ListenAuthUsecase>(),
  MockSpec<UserSignoutUsecase>(),
  MockSpec<FetchUserDataUsecase>(),
  MockSpec<User>(),
])
import 'auth_cubit_test.mocks.dart';

void main() {
  late AuthCubit authCubit;
  late MockListenAuthUsecase listenUseCase;
  late MockUserSignoutUsecase signOutUsecase;
  late MockFetchUserDataUsecase fetchUserDataUsecase;
  late MockUser mockUser;

  setUp(() {
    listenUseCase = MockListenAuthUsecase();
    signOutUsecase = MockUserSignoutUsecase();
    fetchUserDataUsecase = MockFetchUserDataUsecase();
    mockUser = MockUser();
    authCubit = AuthCubit(
      listenUseCase,
      signOutUsecase,
      fetchUserDataUsecase,
    );
  });

  group('Auth Cubit', () {
    test('initial state should be AuthState', () {
      expect(authCubit.state, const AuthState());
    });

    final user = UserEntity(
      uid: 'uid',
      name: 'name',
      email: 'email',
      lastName: 'lastName',
      isOnline: 1,
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Authenticated] when user is not null',
      build: () {
        when(listenUseCase.call()).thenAnswer(
          (_) => Stream.fromIterable([
            mockUser,
          ]),
        );
        return authCubit;
      },
      wait: const Duration(seconds: 1),
      act: (cubit) => cubit.listenAuthState(),
      expect: () => [
        AuthState(
          state: AuthStates.authenticated(),
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Unauthenticated] when user is null',
      build: () {
        when(listenUseCase.call()).thenAnswer(
          (_) => Stream.fromIterable([
            null,
          ]),
        );
        return authCubit;
      },
      act: (cubit) => cubit.listenAuthState(),
      expect: () => [
        AuthState(
          state: AuthStates.unauthenticated(),
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'should set user null when signOut is called',
      build: () {
        when(signOutUsecase.call()).thenAnswer((_) async => Either.right(true));
        return authCubit;
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        AuthState(
          user: null,
          state: AuthStates.unauthenticated(),
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'Should set user in state when setUserInState is called',
      build: () => authCubit,
      seed: () => AuthState(
        user: UserEntity(
          uid: 'uid_',
          name: 'name_',
          email: 'email_',
          lastName: 'lastName_',
          isOnline: 2,
        ),
        state: AuthStates.authenticated(),
      ),
      act: (cubit) => cubit.setUserInState(user),
      expect: () => [
        AuthState(
          user: user,
          state: AuthStates.authenticated(),
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'Should set user in state when fetchUserData is called',
      build: () {
        when(fetchUserDataUsecase.call()).thenAnswer(
          (_) async => Either.right(user),
        );
        return authCubit;
      },
      act: (cubit) => cubit.fetchUserData(),
      expect: () => [
        AuthState(
          user: user,
        ),
      ],
    );
  });
}
