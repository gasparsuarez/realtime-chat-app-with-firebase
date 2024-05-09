import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/profile/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_state.dart';
part 'update_profile_cubit.freezed.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUsecase _usecase;
  UpdateProfileCubit(this._usecase) : super(const UpdateProfileState.initial());

  void updateProfile(UpdateProfileModel model) async {
    emit(const UpdateProfileState.updating());

    final result = await _usecase.call(model);

    switch (result) {
      case Right():
        emit(UpdateProfileState.updated(message: result.right));

        break;
      case Left():
        emit(UpdateProfileState.updateError(message: getFailureMessage(result.left)));
        break;
      default:
    }
  }
}
