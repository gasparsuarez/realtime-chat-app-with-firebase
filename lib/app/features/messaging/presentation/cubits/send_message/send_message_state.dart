part of 'send_message_cubit.dart';

@freezed
class SendMessageState with _$SendMessageState {
  const factory SendMessageState.initial() = _Initial;
  const factory SendMessageState.loading() = Loading;
  const factory SendMessageState.loaded() = Loaded;
  const factory SendMessageState.error(String error) = Error;
}
