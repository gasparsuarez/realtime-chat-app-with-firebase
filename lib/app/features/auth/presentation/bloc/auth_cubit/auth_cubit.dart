import 'dart:async';

import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final ListenAuthUsecase _listenAuthUsecase;
  final UserSignoutUsecase _signOutUsecase;

  StreamSubscription? _streamSubscription;
  AuthCubit(
    this._listenAuthUsecase,
    this._signOutUsecase,
  ) : super(const AuthState());

  ///
  /// Set user data in state
  ///
  void setUserInState(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  ///
  /// Sign Out
  ///
  void signOut() async {
    final result = await _signOutUsecase.call();

    switch (result) {
      case Right():
        emit(state.copyWith(user: null, state: AuthStates.unauthenticated()));
      case _:
        break;
    }
  }

  ///
  /// Listen authentication states
  ///
  void listenAuthState() {
    _streamSubscription = _listenAuthUsecase.call().listen(
      (user) async {
        if (user != null) {
          emit(AuthState(state: AuthStates.authenticated()));
        } else {
          emit(AuthState(state: AuthStates.unauthenticated(), user: null));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
