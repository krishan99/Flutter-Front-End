import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

abstract class ComplexEnum<T> {
  final T _value;
  const ComplexEnum(this._value);
  T get value => _value;
}

class CustomException implements Exception {
  String cause;
  CustomException(this.cause);
}

class MyServerException extends CustomException {
  MyServerException(String cause) : super(cause);
}

class ForbiddenException extends MyServerException {
  ForbiddenException(String cause) : super(cause);
}

class JsonEncodingException extends MyServerException {
  JsonEncodingException(String cause) : super(cause);
}

class InvalidException extends MyServerException {
  InvalidException(String cause) : super(cause);
}

class NotFoundException extends MyServerException {
  NotFoundException(String cause) : super(cause);
}

// class MyServerResponse extends ComplexEnum<int> {
//   final String message;

//   static const success = MyServerResponse._(200);
//   static const forbidden = MyServerResponse._(403);
//   static const jsonError = MyServerResponse._(405);
//   static const invalid = MyServerResponse._(403);
//   static const notFound = MyServerResponse._(404);

//   static const allCases = [success, forbidden, jsonError, invalid, notFound];

//   bool get isSuccess {
//     return value == success.value;
//   }

//   bool get isError {
//     return !isSuccess;
//   }

//   bool operator ==(r) => r is MyServerResponse && r.value == this.value;

//   const MyServerResponse._(int value, {this.message}) : super(value);

//   MyServerResponse(int value, {this.message}) : super(value) {
//     //400 means malformed request - should never happen in production.
//     assert(value != 400);
    
//     // assert(allCases.where((element) => element.value == value).length != 0);
//   }

//   factory MyServerResponse.from({@required http.Response response}) {
//     return MyServerResponse(response.statusCode, message: response.message);
//   }
// }

class MyServerResponse {
  Map<String, dynamic> _body;

  int _statusCode;
  int get statusCode => _statusCode;

  String get message => this["message"] as String;

  dynamic operator [](String key) {
    return _body[key];
  }

  MyServerResponse(http.Response r) {
    this._body = jsonDecode(r.body);
    this._statusCode = r.statusCode;
  }
}

class MyServer {
  final path;
  Future<MyServerResponse> _post(String route, {@required Map body}) async {
    final url = "$path$route";

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body)
    );

    final myServerResponse = MyServerResponse(response);
    _checkResponse(myServerResponse);

    return MyServerResponse(response);
  }

  //TODO: Use firebase Token ID instead.
  Future<MyServerResponse> signIn(String email) async {
    return _post(
      "api/v1/test",
      body: <String, String>{
        "email": email,
      }
    ); 
  }

  _checkResponse(MyServerResponse response) {
    switch (response.statusCode) {
      case 200:
        return;
      case 403:
        throw ForbiddenException(response.message);
      case 405:
        throw JsonEncodingException(response.message);
      case 404:
        throw NotFoundException(response.message);
      default:
        throw Exception(response.message);
    }
  }

  // _checkResponse(MyServerResponse response) {
  //   switch (response) {
  //     case MyServerResponse.success:
  //       return;
  //     case MyServerResponse.forbidden:
  //       throw ForbiddenException(response.message);
  //     case MyServerResponse.invalid:
  //       throw InvalidException(response.message);
  //     case MyServerResponse.jsonError:
  //       throw InvalidException(response.message);
  //     case MyServerResponse.notFound:
  //       throw NotFoundException(response.message);
  //     default:
  //       throw Exception(response.message);
  //   }
  // }

  MyServer({this.path = "http://0.0.0.0:8000/"});
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
  final MyServer server;

  FirebaseUser _firebaseUser;

  bool get isLoggedIn {
    return _firebaseUser != null;
  }

  String get name {
    return _firebaseUser.displayName;
  }

  Future<MyServerResponse> notifyServerOfSignIn(AuthResult result) async {
    return server.signIn(result.user.email);
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

      return notifyServerOfSignIn(result);
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

    signInSilently() async {
      await googleSignIn.signInSilently(suppressErrors: true);
    }

    return notifyServerOfSignIn(result);
  }

  signOut() async {
    await _auth.signOut();
  }

  User({@required this.server}) {
    _auth.onAuthStateChanged.listen((fUser) {
      print(
          "AUTH STATE CHANGED: ${(fUser == null) ? "logged out" : "logged in"}");
      this._firebaseUser = fUser;
      this.notifyListeners();
    });
  }
}
