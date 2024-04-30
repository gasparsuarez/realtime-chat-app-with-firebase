part of 'signin_user_cubit.dart';

@freezed
class SigninUserState with _$SigninUserState {
  const factory SigninUserState.initial() = _Initial;
  const factory SigninUserState.loading() = Loading;
  const factory SigninUserState.loaded() = Loaded;
  const factory SigninUserState.error(String message) = Error;
}
