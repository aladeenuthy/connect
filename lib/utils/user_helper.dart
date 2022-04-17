import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../models/user.dart';

class UserHelper {
  static final _accessToDB = FirebaseFirestore.instance
        .collection('users');
  static Stream<QuerySnapshot<ChatUser>> getUsers() {
    return _accessToDB
        .where('userId', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<ChatUser>(
            fromFirestore: (snapshot, _) =>
                ChatUser.fromDocument(snapshot.data() ?? {}),
            toFirestore: (user, _) => user.toJson())
        .snapshots();
  }

  static Future<ChatUser> getUser(String userId) async {
    var userDoc =
        await _accessToDB.doc(userId).get();
    return ChatUser.fromDocument(userDoc.data() as Map<String, dynamic>);
  }

  static Future<QuerySnapshot<ChatUser>> queryUsers(query) {
    return _accessToDB
        .where('userId', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('username', isEqualTo: query)
        .withConverter<ChatUser>(
            fromFirestore: (snapshot, _) =>
                ChatUser.fromDocument(snapshot.data()!),
            toFirestore: (user, _) => user.toJson())
        .get();
  }
}
