import 'dart:async';

import 'package:firebase_realtime_chat_app/app/features/global/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final ListenAuthUsecase _useCase;
  StreamSubscription? _streamSubscription;
  AuthCubit(this._useCase) : super(const AuthState());

  ///
  /// Listen authentication status of user
  ///
  void listenAuthState() {
    _streamSubscription = _useCase.call().listen(
      (user) {
        if (user != null) {
          emit(AuthState(state: AuthStates.authenticated()));
        } else {
          emit(AuthState(state: AuthStates.unauthenticated()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }
}
