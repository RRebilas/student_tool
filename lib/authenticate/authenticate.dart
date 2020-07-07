import 'package:firebase_auth/firebase_auth.dart';
import 'package:studenttool/models/user.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _firebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get userStream {
    return _auth.onAuthStateChanged.map(_firebaseUser);
  }

  // sing in anonymously
  Future anonymous() async {
    try {
      final FirebaseUser user = (await _auth.signInAnonymously()).user;
      return _firebaseUser(user);
    } catch (e) {
      print(e.toSting());
      return null;
    }
  }

// singing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class EmailAuth extends Authentication {
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return _firebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
