part of 'send_message_cubit.dart';

@freezed
class SendMessageState with _$SendMessageState {
  const factory SendMessageState.initial() = _Initial;
  const factory SendMessageState.sending() = Sending;
  const factory SendMessageState.sent() = Sent;
  const factory SendMessageState.error(String error) = Error;
}
