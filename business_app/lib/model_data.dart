import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ModelData {
  User user;

  ModelData() {
    this.user = User();
  }
}

class User extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseUser _firebaseUser;

  bool get isLoggedIn {
    return _firebaseUser != null;
  }

  String get name {
    return _firebaseUser.displayName;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  User() {
    _auth.onAuthStateChanged.listen((fUser) {
      print("AUTH STATE CHANGED: ${(fUser == null) ? "logged out" : "logged in"}");
      this._firebaseUser = fUser;
      this.notifyListeners();
    });
  }
}


