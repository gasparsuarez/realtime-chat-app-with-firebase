import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Messaging Helpers', () {
    test('Should sort alphabetically', () async {
      final mockId = getMessageCollection('6789', '12345');
      //Assert
      expect(mockId, '12345_6789');
    });
  });
}
