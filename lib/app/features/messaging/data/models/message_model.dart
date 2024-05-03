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
        createdAt: json['createdAt'],
        from: json['from'],
        to: json['to'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'from': from,
        'to': to,
        'content': content,
      };

  MessageEntity toEntity() => MessageEntity(
        messageId: messageId!,
        createdAt: createdAt,
        from: from,
        to: to,
        content: content,
      );
}
