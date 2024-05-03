class ChatRoomModel {
  final String? chatroomId;
  final DateTime createdAt;
  final String from;
  final String to;

  ChatRoomModel({
    this.chatroomId,
    required this.createdAt,
    required this.to,
    required this.from,
  });

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'to': to,
        'from': from,
      };
}
