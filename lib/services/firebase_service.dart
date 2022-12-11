// ignore_for_file: avoid_print, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    return true;
  }

  Future<String?> signInWithEmailAndPassword(
      {required String userEmail, required String userPassword}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return credential.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('Password terlalu lemah!');
      } else if (e.code == 'email-already-in-use') {
        return ('Email sudah terdaftar!');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> signUpWithEmailAndPassword(
      {required String userEmail, required String userPassword}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      return credential.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password terlalu lemah!';
      } else if (e.code == 'email-already-in-use') {
        return 'Email sudah terdaftar!';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
