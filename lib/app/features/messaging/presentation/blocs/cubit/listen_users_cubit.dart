import 'dart:async';

import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'listen_users_state.dart';
part 'listen_users_cubit.freezed.dart';

class ListenUsersCubit extends Cubit<ListenUsersState> {
  final ListenUsersUsecase _useCase;
  StreamSubscription? _streamController;
  ListenUsersCubit(this._useCase) : super(const ListenUsersState.initial());

  void listenUsers() {
    emit(const ListenUsersState.loading());
    _streamController = _useCase.call().listen((users) {
      emit(ListenUsersState.loaded(users: users));
    });
  }

  @override
  Future<void> close() {
    _streamController?.cancel();
    return super.close();
  }
}
