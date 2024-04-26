import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/features/global/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/global/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<ListenAuthUsecase>(),
  MockSpec<User>(),
])
import 'auth_cubit_test.mocks.dart';

void main() {
  late AuthCubit authCubit;
  late MockListenAuthUsecase useCase;

  setUp(() {
    useCase = MockListenAuthUsecase();
    authCubit = AuthCubit(useCase);
  });

  group('Auth Cubit', () {
    test('initial state should be AuthState', () {
      expect(authCubit.state, const AuthState());
    });

    blocTest<AuthCubit, AuthState>(
      'emits [Authenticated] when user is not null',
      build: () {
        when(useCase.call()).thenAnswer(
          (_) => Stream.fromIterable([
            MockUser(),
          ]),
        );
        return authCubit;
      },
      act: (cubit) => cubit.listenAuthState(),
      expect: () => [
        AuthState(
          state: AuthStates.authenticated(),
        )
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [Unauthenticated] when user is null',
      build: () {
        when(useCase.call()).thenAnswer(
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
  });
}
