part of 'listen_users_cubit.dart';

@freezed
class ListenUsersState with _$ListenUsersState {
  const factory ListenUsersState.initial() = _Initial;
  const factory ListenUsersState.loading() = Loading;
  const factory ListenUsersState.loaded({@Default([]) List<UserEntity> users}) = Loaded;
  const factory ListenUsersState.error({String? message}) = Error;
}
