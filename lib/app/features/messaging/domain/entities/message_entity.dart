class MessageEntity {
  final String messageId;
  final DateTime createdAt;
  final String from;
  final String to;
  final String content;

  MessageEntity({
    required this.messageId,
    required this.createdAt,
    required this.from,
    required this.to,
    required this.content,
  });
}
