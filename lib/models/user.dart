class ChatUser{
  final String username, userId, profileUrl, deviceToken ;
  const ChatUser(
      {required this.username, required this.userId, required this.profileUrl, required this.deviceToken});

  factory ChatUser.fromFirestore(Map<String, dynamic> document) {
    return ChatUser(
        username: document['username'] ?? "",
        userId: document['userId'] ?? "",
        profileUrl: document['profileUrl'] ?? '',
        deviceToken: document['deviceToken'] ?? '')
        ;
  }
  Map<String, String> toJson() {
    return {'username': username, 'userId': userId, 'profileUrl': profileUrl, 'deviceToken': deviceToken};
  }
}
