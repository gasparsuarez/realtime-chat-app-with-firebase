import 'dart:io';

import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/domain/usecases/usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_avatar_state.dart';
part 'update_avatar_cubit.freezed.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  final UpdateAvatarUsecase _usecase;

  UpdateAvatarCubit(this._usecase) : super(const UpdateAvatarState.initial());

  void updateAvatar(File file) async {
    emit(const UpdateAvatarState.updatingAvatar());

    final result = await _usecase.call(file);

    switch (result) {
      case Right():
        emit(UpdateAvatarState.updatedAvatar(message: result.right));
        break;
      case Left():
        emit(UpdateAvatarState.updateAvatarError(message: getFailureMessage(result.left)));
        break;
    }
  }
}
