import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  factory Failure.auth(String code) = Auth;
  factory Failure.network({@Default('Network error, try again') String message}) = Network;
  factory Failure.unknown({@Default('Unknown error') String message}) = Unknown;
}

String getFailureMessage(Failure failure) {
  switch (failure) {
    case Network(message: final message):
      return message;
    case Auth(code: final code):
      return parseAuthCodeToMessage(code);
    case Unknown(message: final message):
      return message;
    default:
      return Unknown().message;
  }
}
