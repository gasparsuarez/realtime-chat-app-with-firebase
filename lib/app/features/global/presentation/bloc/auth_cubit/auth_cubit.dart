import 'dart:async';

import 'package:firebase_realtime_chat_app/app/features/auth/domain/domain.dart';
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
  /// Set user data in state
  ///
  void setUserInState(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  ///
  /// Clear State
  ///
  void clearState() {
    emit(state.copyWith(user: null));
  }

  ///
  /// Listen authentication status
  ///
  void listenAuthState() {
    _streamSubscription = _useCase.call().listen(
      (user) {
        if (user != null) {
          emit(state.copyWith(state: AuthStates.authenticated()));
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
