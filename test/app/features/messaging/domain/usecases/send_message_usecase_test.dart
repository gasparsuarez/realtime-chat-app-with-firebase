import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_users_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MessagingRepository>(),
])
void main() {
  late MockMessagingRepository mockMessagingRepository;
  late SendMessageUsecase usecase;

  final mockDate = DateTime(2024, 05, 5);

  final mockModel = MessageModel(
    createdAt: mockDate,
    from: 'from',
    to: 'to',
    content: 'content',
    messageId: 'id',
  );

  setUp(
    () {
      mockMessagingRepository = MockMessagingRepository();
      usecase = SendMessageUsecase(mockMessagingRepository);
    },
  );

  group('Send Message Usecase', () {
    test('Should return true when is success', () async {
      //Arrange
      when(mockMessagingRepository.sendMessage(mockModel)).thenAnswer(
        (_) async => Either.right(true),
      );

      //Act
      final result = await usecase.call(mockModel);

      //Assert

      expect(result.whenOrNull(right: (success) => success), isA<bool>());
      expect(result.whenOrNull(right: (success) => success), true);
    });

    test('Should return failure', () async {
      //Arrange
      when(mockMessagingRepository.sendMessage(mockModel)).thenAnswer(
        (_) async => Either.left(Failure.unknown()),
      );

      //Act
      final result = await usecase.call(mockModel);

      //Assert
      expect(result.whenOrNull(left: (failure) => failure), isA<Failure>());
      expect(result.whenOrNull(left: (failure) => failure), Failure.unknown());
    });
  });
}
