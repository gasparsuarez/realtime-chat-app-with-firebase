import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_state.dart';
part 'send_message_cubit.freezed.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessageUsecase _usecase;

  SendMessageCubit(this._usecase) : super(const SendMessageState.initial());

  ///
  ///  Function for send messages
  ///
  void sendMessage(MessageModel model) async {
    emit(const SendMessageState.loading());
    final result = await _usecase.call(model);

    switch (result) {
      case Right():
        return emit(const SendMessageState.loaded());
      case Left():
        return emit(SendMessageState.error(getFailureMessage(result.left)));
      default:
    }
  }
}
