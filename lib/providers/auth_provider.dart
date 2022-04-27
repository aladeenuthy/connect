import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/helpers/onesignal_helper.dart';
import 'package:connect/utils/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider  {
  final _googleSignIn = GoogleSignIn(); //google sign in obj
  GoogleSignIn get googleSignIn {
    return _googleSignIn;
  }

  final auth = FirebaseAuth.instance; // firebase obj
  UserCredential? _userCredential;
  UserCredential get userCredential {
    return _userCredential as UserCredential;
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      _userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Authentication failed");
    } catch (_) {
      showSnackBar("Authentication failed");
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Authentication failed");
    } catch (_) {
      showSnackBar("Authentication failed");
    }
    return false;
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return false;
    }
    final googleSignInAuth = await googleSignInAccount.authentication;
    final credentials = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken);

    try {
      _userCredential = await auth
          .signInWithCredential(credentials); //signing in with credentials
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        showSnackBar("account with credential already exists");
      } else if (e.code == 'invalid-credential') {
        showSnackBar("invalid credentials");
      }
    } catch (e) {
      showSnackBar("Authentication failed");
    }
    return false;
  }

  Future<bool> saveUserDetails(File image, String userName) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pics')
          .child(FirebaseAuth.instance.currentUser!.uid + ".jpg");

      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      await auth.currentUser?.updateDisplayName(userName);
      await auth.currentUser?.updatePhotoURL(url);
      final deviceToken = await OneSignalHelper.deviceToken() as String;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .set({
        'username': userName,
        "userId": auth.currentUser?.uid,
        "profileUrl": url,
        'deviceToken' :deviceToken
      });
      return true;
    } on FirebaseException catch (e) {
      showSnackBar(e.message ?? "Something went wrong");
    } catch (e) {
      showSnackBar(e.toString());
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await _googleSignIn.disconnect();
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Something went wrong");
    } catch (e) {
      showSnackBar("something went wrong");
    }
    return false;
  }
}
