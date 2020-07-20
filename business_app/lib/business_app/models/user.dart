import 'dart:collection';
import 'dart:convert';

import 'package:business_app/business_app/services/services.dart';
import 'package:business_app/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:business_app/business_app/models/queues.dart';

//When this file gets to big, split into multiple files.

abstract class ComplexEnum<T> {
  final T _value;
  const ComplexEnum(this._value);
  T get value => _value;
}

class ModelData {
  User user;
  //Queues queues;
  BusinessAppServer server;
  AllQueuesInfo qinfo;

  ModelData() {
    this.server = BusinessAppServer();
    this.user = User(server: server);
    //this.queues = Queues();
    this.qinfo = AllQueuesInfo(server: server);
  }
}

class User extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final BusinessAppServer server;

  FirebaseUser _firebaseUser;
  String email;

  bool get isLoggedIn {
    return _firebaseUser != null;
  }

  String get name {
    return _firebaseUser.displayName;
  }

  Future<void> notifyServerOfSignIn(String email) async {
    await server.signIn(email);
    server.connectSocket();
    this.email = email;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      email = result.user.email;
      return notifyServerOfSignIn(result.user.email);
  }

  Future<void> signUp({String name, @required String email, @required String password}) async {
    AuthResult result;

    try {
      result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      String errorMessage = getFirebaseErrorMessage(firebaseErrorCode: error.toString());
      throw CustomException(errorMessage);
    }

    return notifyServerOfSignIn(result.user.email);
    // print("email: $email, password: $password");
    // return null;
  }

  String getFirebaseErrorMessage({@required String firebaseErrorCode}) {
    switch (firebaseErrorCode) {
        case "ERROR_INVALID_EMAIL":
          return "Your email address appears to be malformed.";
        case "ERROR_WRONG_PASSWORD":
          return "Your password is wrong.";
        case "ERROR_USER_NOT_FOUND":
          return "User with this email doesn't exist.";
        case "ERROR_USER_DISABLED":
          return "User with this email has been disabled.";
        case "ERROR_TOO_MANY_REQUESTS":
          return "Too many requests. Try again later.";
        case "ERROR_OPERATION_NOT_ALLOWED":
          return "Signing in with Email and Password is not enabled.";
        default:
          return "An undefined error happened. code: $firebaseErrorCode";
      }
  }

  Future<void> signIn(String email, String password) async {
    AuthResult result;

    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      String errorMessage = getFirebaseErrorMessage(firebaseErrorCode: error.code);
      throw CustomException(errorMessage);
    }

    return notifyServerOfSignIn(result.user.email);
  }

  Future<void> signInSilently() async {
      await googleSignIn.signInSilently(suppressErrors: true);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    //TODO: Sign out from server? Idk if this is needed.
  }

  User({@required this.server}) {
    _auth.onAuthStateChanged.listen((fUser) async {
      this._firebaseUser = fUser;
      print(
          "AUTH STATE CHANGED: ${this.isLoggedIn}");
      //var k = await server.signIn(email);
      //await server.connectSocket();
      //this.notifyListeners();
    });
  }
}
