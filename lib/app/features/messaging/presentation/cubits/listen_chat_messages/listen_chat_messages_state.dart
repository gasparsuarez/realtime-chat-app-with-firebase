part of 'listen_chat_messages_cubit.dart';

@freezed
class ListenChatMessagesState with _$ListenChatMessagesState {
  const factory ListenChatMessagesState.initial() = _Initial;
  const factory ListenChatMessagesState.loading() = _Loading;
  const factory ListenChatMessagesState.listening({@Default([]) List<MessageEntity> messages}) =
      Listening;
  const factory ListenChatMessagesState.error(String error) = Error;
}
