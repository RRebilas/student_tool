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
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _firebaseUser(user);
    } catch (e) {
      print(e.toSting());
      return null;
    }
  }

//  TODO: implement button to signing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
