import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/data/data.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/presentation/bloc/register_user/register_user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UserRegisterUsecase>()])
import 'register_user_cubit_test.mocks.dart';

void main() {
  late RegisterUserCubit registerUserCubit;
  late MockUserRegisterUsecase mockUsecase;

  setUp(
    () {
      mockUsecase = MockUserRegisterUsecase();
      registerUserCubit = RegisterUserCubit(mockUsecase);
    },
  );

  tearDown(() {
    registerUserCubit.close();
  });

  group(
    'Register User Cubit',
    () {
      final dto = UserModel(
        name: 'name',
        email: 'email',
        password: 'password',
        lastName: 'lastName',
      );

      test('Initial state should be initial', () {
        //Assert
        expect(registerUserCubit.state, const Initial());
      });

      blocTest<RegisterUserCubit, RegisterUserState>(
        'emits [loading, loaded] when Register is called.',
        build: () {
          when(mockUsecase.call(any)).thenAnswer((_) async => Either.right(''));
          return registerUserCubit;
        },
        act: (cubit) => cubit.register(dto),
        expect: () => [
          const Loading(),
          const Loaded(''),
        ],
      );
      blocTest<RegisterUserCubit, RegisterUserState>(
        'emits [loading, Error] when Register is called.',
        build: () {
          when(mockUsecase.call(dto)).thenAnswer(
            (_) async => Either.left(AuthFailure.invalidEmail()),
          );
          return registerUserCubit;
        },
        act: (cubit) => cubit.register(dto),
        expect: () => [
          const Loading(),
          Error(AuthFailure.invalidEmail().message),
        ],
      );
    },
  );
}
