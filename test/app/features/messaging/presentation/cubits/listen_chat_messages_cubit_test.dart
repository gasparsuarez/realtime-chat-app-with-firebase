import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/domain/usecases/listen_chat_messages_usecase.dart';
import 'package:firebase_realtime_chat_app/app/features/messaging/presentation/cubits/listen_chat_messages/listen_chat_messages_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'listen_chat_messages_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ListenChatMessagesUsecase>(),
])
void main() {
  late ListenChatMessagesCubit listenChatMessagesCubit;
  late MockListenChatMessagesUsecase mockListenChatMessagesUsecase;

  setUp(() {
    mockListenChatMessagesUsecase = MockListenChatMessagesUsecase();
    listenChatMessagesCubit = ListenChatMessagesCubit(
      mockListenChatMessagesUsecase,
    );
  });

  group('Listen Chat Messages Cubit', () {
    test('initial state should be Initial()', () async {
      //Assert
      expect(listenChatMessagesCubit.state, const ListenChatMessagesState.initial());
    });

    final mockList = [
      MessageEntity(
        messageId: 'messageId',
        createdAt: DateTime.now(),
        from: '',
        to: 'to',
        content: 'content',
      )
    ];

    blocTest<ListenChatMessagesCubit, ListenChatMessagesState>(
      'emits [Loading, Listening] when listenChatMessages is added.',
      build: () {
        when(mockListenChatMessagesUsecase.call(any)).thenAnswer(
          (_) => Stream.fromIterable([mockList]),
        );
        return listenChatMessagesCubit;
      },
      act: (cubit) => cubit.listenChatMessages('id'),
      expect: () => [
        const ListenChatMessagesState.listen(),
        ListenChatMessagesState.listening(messages: mockList),
      ],
    );
  });
}
