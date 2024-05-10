part of 'update_profile_cubit.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;
  const factory UpdateProfileState.updating() = Updating;
  const factory UpdateProfileState.updated({required String message}) = Updated;
  const factory UpdateProfileState.updateError({required String message}) = UpdateError;
}
