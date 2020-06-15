import 'dart:collection';
import 'dart:convert';

import 'package:business_app/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class ComplexEnum<T> {
  final T _value;
  const ComplexEnum(this._value);
  T get value => _value;
}

class ModelData {
  User user;
  Queues queues;
  MyServer server;

  ModelData() {
    this.server = MyServer();
    this.user = User(server: server);
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

  int id;

  int get numWaiting {
    return _getNumOfState(QueueEntryState.waiting);
  }
  
  int get numNotified {
    return _getNumOfStates([QueueEntryState.notified, QueueEntryState.pendingNotification]);
  }

  int get numCompleted {
    return _getNumOfStates([QueueEntryState.notified, QueueEntryState.pendingDeletion]);
  }

  int _getNumOfStates(List<QueueEntryState> states) {
    return data.where((element) => states.contains(element.state)).length;
  }

  int _getNumOfState(QueueEntryState state) {
    return _getNumOfStates([state]);
  }

  // Future<MyServerResponse> updateCode(String newCode) {
  //   this._code = newCode;

  //   notifyListeners();
  // }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,
      'qid': id,
      'qname': name
    };
  }

  static Queue fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Queue(
      code: map['code'],
      description: map['description'],
      id: map['qid'],
      name: map['qname'],
      state: QueueState.inactive
    );
  }

  String toJson() => json.encode(toMap());

  static Queue fromJson(String source) => fromMap(json.decode(source));

  Queue({
      @required String name, 
      this.id,
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
  final MyServer server;

  FirebaseUser _firebaseUser;

  bool get isLoggedIn {
    return _firebaseUser != null;
  }

  String get name {
    return _firebaseUser.displayName;
  }

  Future<MyServerResponse> notifyServerOfSignIn(String email) async {
    return server.signIn(email);
  }

  Future<MyServerResponse> signInWithGoogle() async {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final result = await _auth.signInWithCredential(credential);

      return notifyServerOfSignIn(result.user.email);
  }

  Future<MyServerResponse> signIn(String email, String password) async {
    AuthResult result;

    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      String errorMessage;
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

      throw CustomException(errorMessage);
    }

    return notifyServerOfSignIn(result.user.email);
  }

  signInSilently() async {
      await googleSignIn.signInSilently(suppressErrors: true);
  }

  signOut() async {
    await _auth.signOut();
  }

  User({@required this.server}) {
    _auth.onAuthStateChanged.listen((fUser) {
      this._firebaseUser = fUser;
      print(
          "AUTH STATE CHANGED: ${this.isLoggedIn}");
      this.notifyListeners();
    });
  }
}
