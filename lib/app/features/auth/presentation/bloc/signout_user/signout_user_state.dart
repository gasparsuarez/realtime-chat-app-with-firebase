part of 'signout_user_cubit.dart';

@freezed
class SignoutUserState with _$SignoutUserState {
  const factory SignoutUserState.initial() = _Initial;
  const factory SignoutUserState.error(String message) = Error;
}
