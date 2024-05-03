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

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'from': from,
        'to': to,
        'content': content,
      };
}
