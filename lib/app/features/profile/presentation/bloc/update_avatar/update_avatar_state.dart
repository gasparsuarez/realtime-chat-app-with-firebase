part of 'update_avatar_cubit.dart';

@freezed
class UpdateAvatarState with _$UpdateAvatarState {
  const factory UpdateAvatarState.initial() = _Initial;
  const factory UpdateAvatarState.updatingAvatar() = UpdatingAvatar;
  const factory UpdateAvatarState.updatedAvatar({String? message}) = UpdatedAvatar;
  const factory UpdateAvatarState.updateAvatarError({String? message}) = UpdateAvatarError;
}
