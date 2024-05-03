import 'package:firebase_realtime_chat_app/app/features/messaging/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mockDate = DateTime(2024, 05, 5);

  final mockModel = MessageModel(
      createdAt: mockDate, from: 'from', to: 'to', content: 'content', messageId: 'id');

  group('Message Model', () {
    test('Should create a valid model', () async {
      //Assert
      expect(mockModel, isA<MessageModel>());
      expect(mockModel.createdAt, mockDate);
      expect(mockModel.from, 'from');
      expect(mockModel.to, 'to');
      expect(mockModel.content, 'content');
      expect(mockModel.messageId, 'id');
    });

    test('Should create a valid JSON', () async {
      final mockJson = mockModel.toJson();
      //Assert
      expect(mockJson, isA<Map<String, dynamic>>());
      expect(mockJson['from'], 'from');
      expect(mockJson['to'], 'to');
      expect(mockJson['content'], 'content');
      expect(mockJson['createdAt'], mockDate.toIso8601String());
    });
  });
}
