import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../models/user.dart';

class UserHelper {
  static final _accessToDB = FirebaseFirestore.instance
        .collection('users');
  // get all users in app and converts to ChatUser model instance
  static Stream<QuerySnapshot<ChatUser>> getUsers() {
    return _accessToDB
        .where('userId', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<ChatUser>(
            fromFirestore: (snapshot, _) =>
                ChatUser.fromFirestore(snapshot.data() ?? {}),
            toFirestore: (user, _) => user.toJson())
        .snapshots();
  }
  // get a particular user to get access to its, image, device Token and username
  static Future<ChatUser> getUser(String userId) async {
    var userDoc =
        await _accessToDB.doc(userId).get();
    return ChatUser.fromFirestore(userDoc.data() as Map<String, dynamic>);
  }
  // search for a user, has to be exact username, will update later
  static Future<QuerySnapshot<ChatUser>> queryUsers(query) {
    return _accessToDB
        .where('userId', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('username', isEqualTo: query)
        .withConverter<ChatUser>(
            fromFirestore: (snapshot, _) =>
                ChatUser.fromFirestore(snapshot.data()!),
            toFirestore: (user, _) => user.toJson())
        .get();
  }
}
