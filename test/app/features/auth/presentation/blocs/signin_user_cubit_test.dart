import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/signin_user/signin_user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UserSigninUsecase>()])
import 'signin_user_cubit_test.mocks.dart';

void main() {
  late SigninUserCubit signinUserCubit;
  late MockUserSigninUsecase mockUsecase;

  setUp(
    () {
      mockUsecase = MockUserSigninUsecase();
      signinUserCubit = SigninUserCubit(mockUsecase);
    },
  );

  group(
    'Sign In Cubit',
    () {
      test('initial state should be initial', () async {
        //Assert
        expect(signinUserCubit.state, const SigninUserState.initial());
      });

      blocTest<SigninUserCubit, SigninUserState>(
        'emits [Loading, Loaded] when SignIn is called.',
        build: () {
          when(mockUsecase.call(any, any)).thenAnswer(
            (_) async => Either.right(true),
          );
          return signinUserCubit;
        },
        act: (cubit) => cubit.signIn('email', 'password'),
        expect: () => [
          const SigninUserState.loading(),
          const SigninUserState.loaded(),
        ],
      );

      blocTest<SigninUserCubit, SigninUserState>(
        'emits [Loading, Error] when SignIn is called.',
        build: () {
          when(mockUsecase.call(any, any)).thenAnswer(
            (_) async => Either.left(Failure.auth('user-not-found')),
          );
          return signinUserCubit;
        },
        act: (cubit) => cubit.signIn('email', 'password'),
        expect: () => [
          const SigninUserState.loading(),
          const SigninUserState.error('User not corresponding to the given email'),
        ],
      );
    },
  );
}
