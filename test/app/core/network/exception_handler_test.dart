import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/core/network/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Exception Handler', () {
    test('Should return Auth Failure when is FirebaseException', () async {
      //Act
      final failure =
          ExceptionHandler.handleException(FirebaseAuthException(code: 'wrong-password'));
      //Assert
      expect(failure, isA<Failure>());
      expect(failure, Failure.auth('wrong-password'));
    });

    test('Should return Network Failure when is SocketException', () async {
      //Act
      final failure = ExceptionHandler.handleException(const SocketException(''));
      //Assert
      expect(failure, isA<Failure>());
      expect(failure, Failure.network());
    });
  });
}
