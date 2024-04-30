import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_user_state.dart';
part 'signin_user_cubit.freezed.dart';

class SigninUserCubit extends Cubit<SigninUserState> {
  final UserSigninUsecase _useCase;
  SigninUserCubit(this._useCase) : super(const SigninUserState.initial());

  ///
  /// Signin with email and password
  ///
  void signIn(String email, String password) async {
    emit(const SigninUserState.loading());

    // Execute usecase
    final result = await _useCase.call(email, password);

    // result filter
    switch (result) {
      case Left():
        return emit(SigninUserState.error(getFailureMessage(result.left)));
      case Right():
        return emit(const SigninUserState.loaded());
      default:
        null;
    }
  }
}
