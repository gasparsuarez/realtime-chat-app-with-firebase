import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/core/core.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/messaging.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/cubits/send_message/send_message_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'send_message_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SendMessageUsecase>(),
])
void main() {
  late MockSendMessageUsecase mockSendMessageUsecase;
  late SendMessageCubit sendMessageCubit;

  setUp(
    () {
      mockSendMessageUsecase = MockSendMessageUsecase();
      sendMessageCubit = SendMessageCubit(
        mockSendMessageUsecase,
      );
    },
  );

  final mockModel = MessageModel(
    createdAt: DateTime(2024, 05, 5),
    from: 'from',
    to: 'to',
    content: 'content',
  );

  group('Send Message Cubit', () {
    test('Initial state should be Initial()', () async {
      //Assert
      expect(sendMessageCubit.state, const SendMessageState.initial());
    });

    blocTest<SendMessageCubit, SendMessageState>(
      'emits [Loading, Loaded] when sendMessage is added.',
      build: () {
        when(mockSendMessageUsecase.call(any)).thenAnswer((_) async => Either.right(true));
        return sendMessageCubit;
      },
      act: (cubit) => cubit.sendMessage(mockModel),
      expect: () => [
        const SendMessageState.loading(),
        const SendMessageState.loaded(),
      ],
    );

    blocTest<SendMessageCubit, SendMessageState>(
      'emits [Loading, Error] when sendMessage is added.',
      build: () {
        when(mockSendMessageUsecase.call(any)).thenAnswer(
          (_) async => Either.left(Failure.unknown()),
        );
        return sendMessageCubit;
      },
      act: (cubit) => cubit.sendMessage(mockModel),
      expect: () => [
        const SendMessageState.loading(),
        const SendMessageState.error('Unknown error'),
      ],
    );
  });
}
