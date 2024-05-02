class ChatRoomModel {
  final String? chatroomId;
  final DateTime createdAt;
  final List<String> members;

  ChatRoomModel({
    this.chatroomId,
    required this.createdAt,
    required this.members,
  });

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toIso8601String(),
        'members': members,
      };
}
