import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

//TODO: Reemplazar por enum

@freezed
sealed class AuthFailure with _$AuthFailure {
  factory AuthFailure.emailAlreadyUsed({@Default('Email is already used!') String message}) =
      _EmailAlreadyUsed;
  factory AuthFailure.wrongPassword({@Default('The pasword is wrong!') String message}) =
      _WrongPassword;
  factory AuthFailure.invalidCredential({@Default('Wrong user or password') String message}) =
      _InvalidCredential;
  factory AuthFailure.invalidEmail({@Default('Enter a valid email!') String message}) =
      _InvalidEmail;
  factory AuthFailure.userNotFound(
      {@Default('User not corresponding to the given email') String message}) = _UserNotFound;
  factory AuthFailure.unknown({@Default('Unknown error') String message}) = _Unknown;
}
