import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ModelData {
  User user;
  Queues queues;

  ModelData() {
    this.user = User();
    this.queues = Queues();
  }
}

enum QueueEntryState {
  notified,
  pendingNotification,
  waiting,
  pendingDeletion,
  deleted
}

mixin Titled on ChangeNotifier {
  String _name;
  String get name => _name;
  set name(String newValue) {
    _name = newValue;
    notifyListeners();
  }

  String _description;

  String get description => _description;
  set description(String newValue) {
    _description = newValue;
    notifyListeners();
  }
}

class QueueEntry with ChangeNotifier, Titled {
  QueueEntryState _state;
  QueueEntryState get state => _state;
  set state(QueueEntryState newValue) {
    _state = newValue;
    notifyListeners();
  }

  QueueEntry({
    String name,
    String description,
    QueueEntryState state = QueueEntryState.waiting,
  }) {
    this._name = name;
    this._description = description;
    this._state = state;
  }
}

class ListenableList<E> extends ListBase<E> with ChangeNotifier {
  final List<E> data = [];

  int get length => data.length;

  set length(int newLength) {
    data.length = newLength; 
    notifyListeners();
  }
  
  E operator [](int index) {
    return data[index];
  }

  void operator []=(int index, E value) {
    data[index] = value; 
    notifyListeners();
  }
}

enum QueueState {
  active, inactive
}

class Queue extends ListenableList<QueueEntry> with Titled {
  QueueState _state;
  QueueState get state => _state;
  set state(QueueState newValue) {
    _state = newValue;
    notifyListeners();
  }

  String _code;
  String get code => _code;
  set code(String newValue) {
    _code = newValue;
    notifyListeners();
  }

  int get numWaiting {
    return _getNumOfState(QueueEntryState.waiting);
  }
  
  int get numNotified {
    return _getNumOfState(QueueEntryState.notified) + _getNumOfState(QueueEntryState.pendingNotification);
  }

  int get numCompleted {
    return _getNumOfState(QueueEntryState.notified) + _getNumOfState(QueueEntryState.pendingDeletion);
  }

  int _getNumOfState(QueueEntryState state) {
    return data.where((element) => element.state == state).length;
  }

  Queue({
      @required String name, 
      String description = "Swipe from the left to delete this queue and swipe right to see more details.",
      QueueState state = QueueState.inactive,
      @required String code}) {

    this._name = name;
    this._description = description;
    this._code = code;
    this._state = state;
  }
}

class Queues extends ListenableList<Queue> {}

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
