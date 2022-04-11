import 'dart:io';

import 'package:connect/utils/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  UserCredential? _userCredential;
  UserCredential get userCredential {
    return _userCredential as UserCredential;
  }

  Future<bool> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Authentication failed", context);
    } catch (_) {
      showSnackBar("Authentication failed", context);
    }
    return false;
  }

  Future<bool> signIn(
      String email, String password, BuildContext context) async {
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Authentication failed", context);
    } catch (_) {
      showSnackBar("Authentication failed", context);
    }
    return false;
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
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
      _userCredential = await _auth.signInWithCredential(credentials);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        showSnackBar("account with credential already exists", context);
      } else if (e.code == 'invalid-credential') {
        showSnackBar("invalid credentials", context);
      }
    } catch (e) {
      showSnackBar("Authentication failed", context);
    }
    return false;
  }

  Future<bool> saveUserDetails(
      File image, String userName, BuildContext context) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pics')
          .child(FirebaseAuth.instance.currentUser!.uid + ".jpg");
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      await _auth.currentUser?.updateDisplayName(userName);
      await _auth.currentUser?.updatePhotoURL(url);
      return true;
    } on FirebaseException catch (e) {
      showSnackBar(e.message ?? "Something went wrong", context);
    } catch (e) {
      showSnackBar("something went wrong", context);
    }
    return false;
  }

  Future<bool> signOut(BuildContext context) async {
    try {
      googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message ?? "Something went wrong", context);
    } catch (e) {
      showSnackBar("something went wrong", context);
    }
    return false;
  }
}
