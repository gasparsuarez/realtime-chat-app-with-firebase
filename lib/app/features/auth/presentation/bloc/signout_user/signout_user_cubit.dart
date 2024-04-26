import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signout_user_state.dart';
part 'signout_user_cubit.freezed.dart';

class SignoutUserCubit extends Cubit<SignoutUserState> {
  final UserSignoutUsecase _useCase;
  SignoutUserCubit(this._useCase) : super(const SignoutUserState.initial());

  //TODO: Realizar test

  void signOut() async {
    final result = await _useCase.call();

    switch (result) {
      case Left():
        emit(SignoutUserState.error(result.left.message));
        break;
      default:
        null;
    }
  }
}
