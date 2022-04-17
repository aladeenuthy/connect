class ChatUser{
  final String username, userId, profileUrl ;
  const ChatUser(
      {required this.username, required this.userId, required this.profileUrl});

  factory ChatUser.fromDocument(Map<String, dynamic> document) {
    return ChatUser(
        username: document['username'] ?? "",
        userId: document['userId'] ?? "",
        profileUrl: document['profileUrl'] ?? '');
  }
  Map<String, String> toJson() {
    return {'username': username, 'userId': userId, 'profileUrl': profileUrl};
  }
}
