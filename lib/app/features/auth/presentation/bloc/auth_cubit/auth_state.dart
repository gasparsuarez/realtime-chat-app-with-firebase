part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    AuthStates? state,
    UserEntity? user,
  }) = _AuthState;
}
