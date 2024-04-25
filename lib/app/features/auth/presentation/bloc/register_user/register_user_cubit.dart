import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_user_state.dart';
part 'register_user_cubit.freezed.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  final UserRegisterUsecase _useCase;
  RegisterUserCubit(this._useCase) : super(const RegisterUserState.initial());

  void register(CreateUserDto dto) async {
    emit(const RegisterUserState.loading());

    final result = await _useCase.call(dto);

    switch (result) {
      case Right():
        emit(RegisterUserState.loaded(result.right));
      case Left():
        emit(RegisterUserState.error(
          result.left.message,
        ));
    }
  }
}
