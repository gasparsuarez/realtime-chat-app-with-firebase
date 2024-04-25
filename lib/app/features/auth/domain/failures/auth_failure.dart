import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  factory AuthFailure.emailAlreadyUsed({
    @Default('Email is already used!') String message,
  }) = _EmailAlreadyUsed;
  factory AuthFailure.wrongPassword({
    @Default('The pasword is wrong!') String message,
  }) = _WrongPassword;
  factory AuthFailure.invalidEmail({
    @Default('Enter a valid email!') String message,
  }) = _InvalidEmail;
  factory AuthFailure.unknown({
    @Default('Unknown error') String message,
  }) = _Unknown;
}
