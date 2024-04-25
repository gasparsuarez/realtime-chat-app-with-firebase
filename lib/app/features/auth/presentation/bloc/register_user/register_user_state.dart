part of 'register_user_cubit.dart';

@freezed
sealed class RegisterUserState with _$RegisterUserState {
  const factory RegisterUserState.initial() = Initial;
  const factory RegisterUserState.loading() = Loading;
  const factory RegisterUserState.loaded(String message) = Loaded;
  const factory RegisterUserState.error(String message) = Error;
}
