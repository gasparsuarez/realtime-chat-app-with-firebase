import 'dart:async';

import 'package:firebase_realtime_chat_app/app/features/messaging/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'listen_chat_messages_state.dart';
part 'listen_chat_messages_cubit.freezed.dart';

class ListenChatMessagesCubit extends Cubit<ListenChatMessagesState> {
  final ListenChatMessagesUsecase _usecase;
  StreamSubscription? _streamSubscription;
  ListenChatMessagesCubit(this._usecase) : super(const ListenChatMessagesState.initial());

  void listenChatMessages(String chatroomId) {
    emit(const ListenChatMessagesState.loading());

    _streamSubscription = _usecase.call(chatroomId).listen((event) {
      emit(ListenChatMessagesState.listening(messages: event));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
