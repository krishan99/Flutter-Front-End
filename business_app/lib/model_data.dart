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
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final result = await _auth.signInWithCredential(credential);

      return result.user.uid;
  }

  //TODO: use enums instead of strings.
  Future<String> signIn(String email, String password) async {
    FirebaseUser user;
    String errorMessage;

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    signInSilently() async {
      await googleSignIn.signInSilently(suppressErrors: true);
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return user.uid;
  }

  signOut() async {
    await _auth.signOut();
  }

  User() {
    _auth.onAuthStateChanged.listen((fUser) {
      print(
          "AUTH STATE CHANGED: ${(fUser == null) ? "logged out" : "logged in"}");
      this._firebaseUser = fUser;
      this.notifyListeners();
    });
  }
}
