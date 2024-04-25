import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_states.freezed.dart';

@freezed
sealed class AuthStates with _$AuthStates {
  factory AuthStates.authenticated() = _Authenticated;
  factory AuthStates.unauthenticated() = _Unauthenticated;
}
