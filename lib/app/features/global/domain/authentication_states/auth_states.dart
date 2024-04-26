import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_states.freezed.dart';

@freezed
sealed class AuthStates with _$AuthStates {
  factory AuthStates.authenticated() = Authenticated;
  factory AuthStates.unauthenticated() = Unauthenticated;
}
