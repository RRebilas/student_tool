import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studenttool/models/user.dart';

class Authentication with ChangeNotifier {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  User _firebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  Stream<User> get userStream {
    return _authInstance.onAuthStateChanged.map(_firebaseUser);
  }

  // sing in anonymously
  Future<User> anonymous() async {
    return (await _authInstance
        .signInAnonymously()
        .then((result) => _firebaseUser(result.user)));
  }

// singing out
  Future signOut() async => await _authInstance.signOut();
}

class EmailAuth extends Authentication {
  Future<User> registerWithEmailAndPassword(
          String email, String password) async =>
      await _authInstance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) => _firebaseUser(result.user));

  Future<User> loginWithEmailAndPassword(String email, String password) async =>
      await _authInstance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) => _firebaseUser(result.user));

//TODO: implement email verification
  Future sendVerificationEmail() async => await _authInstance
      .currentUser()
      .then((value) => value.sendEmailVerification());
}

class GoogleAuth extends Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    return await _authInstance
        .signInWithCredential(credential)
        .then((result) => _firebaseUser(result.user));
  }
}
