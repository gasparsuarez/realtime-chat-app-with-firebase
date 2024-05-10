import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/usecases/usecases.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/bloc/update_avatar/update_avatar_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<UpdateAvatarUsecase>(),
])
import 'update_avatar_cubit_test.mocks.dart';

void main() {
  late MockUpdateAvatarUsecase mockUsecase;
  late UpdateAvatarCubit updateAvatarCubit;

  setUp(() {
    mockUsecase = MockUpdateAvatarUsecase();
    updateAvatarCubit = UpdateAvatarCubit(mockUsecase);
  });

  group(
    'Update Avatar Cubit',
    () {
      test('Initial state should be Initial()', () async {
        //Assert
        expect(updateAvatarCubit.state, const UpdateAvatarState.initial());
      });

      blocTest<UpdateAvatarCubit, UpdateAvatarState>(
        'emits [UpdatingAvatar, UpdatedAvatar] when updateAvatar is added.',
        build: () {
          when(mockUsecase.call(any)).thenAnswer((_) async => Either.right('Avatar is updated!'));
          return updateAvatarCubit;
        },
        act: (cubit) => cubit.updateAvatar(File('')),
        expect: () => [
          const UpdateAvatarState.updatingAvatar(),
          const UpdateAvatarState.updatedAvatar(message: 'Avatar is updated!'),
        ],
      );

      blocTest<UpdateAvatarCubit, UpdateAvatarState>(
        'emits [UpdatingAvatar, UpdateAvatarError] when updateAvatar is added.',
        build: () {
          when(mockUsecase.call(any)).thenAnswer((_) async => Either.left(Failure.unknown()));
          return updateAvatarCubit;
        },
        act: (cubit) => cubit.updateAvatar(File('')),
        expect: () => [
          const UpdateAvatarState.updatingAvatar(),
          const UpdateAvatarState.updateAvatarError(message: 'Unknown error'),
        ],
      );
    },
  );
}
