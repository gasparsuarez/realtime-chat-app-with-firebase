import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/data/models/models.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/usecases/usecases.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/presentation/bloc/cubit/update_profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<UpdateProfileUsecase>(),
])
import 'update_profile_cubit_test.mocks.dart';

void main() {
  late UpdateProfileCubit updateProfileCubit;
  late MockUpdateProfileUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockUpdateProfileUsecase();
    updateProfileCubit = UpdateProfileCubit(
      mockUsecase,
    );
  });

  group(
    'Update Profile Cubit',
    () {
      final model = UpdateProfileModel(
        name: 'name',
        lastName: 'lastName',
      );

      test('Initial state should be initial()', () async {
        //Assert
        expect(updateProfileCubit.state, const UpdateProfileState.initial());
      });

      blocTest<UpdateProfileCubit, UpdateProfileState>(
        'emits [Updating, Updated] when updateProfile is added.',
        build: () {
          when(mockUsecase.call(any)).thenAnswer(
            (_) async => Either.right('Profile has been updated'),
          );
          return updateProfileCubit;
        },
        act: (cubit) => cubit.updateProfile(model),
        expect: () => [
          const UpdateProfileState.updating(),
          const UpdateProfileState.updated(message: 'Profile has been updated')
        ],
      );
      blocTest<UpdateProfileCubit, UpdateProfileState>(
        'emits [Updating, UpdateError] when updateProfile is added.',
        build: () {
          when(mockUsecase.call(any)).thenAnswer(
            (_) async => Either.left(Failure.unknown(message: 'Unknown error')),
          );
          return updateProfileCubit;
        },
        act: (cubit) => cubit.updateProfile(model),
        expect: () => [
          const UpdateProfileState.updating(),
          const UpdateProfileState.updateError(message: 'Unknown error')
        ],
      );
    },
  );
}
