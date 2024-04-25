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

      final user = UserEntity(
        uid: 'uid',
        name: 'name',
        email: 'email',
        lastName: 'lastName',
        isOnline: 1,
      );

      blocTest<SigninUserCubit, SigninUserState>(
        'emits [Loading, Loaded] when SignIn is called.',
        build: () {
          when(mockUsecase.call(any, any)).thenAnswer(
            (_) async => Either.right(user),
          );
          return signinUserCubit;
        },
        act: (cubit) => cubit.signIn('email', 'password'),
        expect: () => [
          const SigninUserState.loading(),
          SigninUserState.loaded(user),
        ],
      );

      final failure = AuthFailure.userNotFound();
      blocTest<SigninUserCubit, SigninUserState>(
        'emits [Loading, Error] when SignIn is called.',
        build: () {
          when(mockUsecase.call(any, any)).thenAnswer(
            (_) async => Either.left(failure),
          );
          return signinUserCubit;
        },
        act: (cubit) => cubit.signIn('email', 'password'),
        expect: () => [
          const SigninUserState.loading(),
          SigninUserState.error(failure.message),
        ],
      );
    },
  );
}
