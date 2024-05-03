import 'package:firebase_realtime_chat_app/app/features/messaging/domain/entities/message_entity.dart';

class MessageModel {
  final String? messageId;
  final DateTime createdAt;
  final String from;
  final String to;
  final String content;

  MessageModel({
    this.messageId,
    required this.createdAt,
    required this.from,
    required this.to,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      createdAt: DateTime.parse(json['createdAt']),
      from: json['from'],
      to: json['to'],
      content: json['content'],
      messageId: json['messageId']);

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'from': from,
        'to': to,
        'content': content,
      };

  static MessageEntity toEntity(MessageModel model) => MessageEntity(
        messageId: model.messageId ?? '',
        createdAt: model.createdAt,
        from: model.from,
        to: model.to,
        content: model.content,
      );
}
