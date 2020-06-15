import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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

  MyServer({this.path = "http://0.0.0.0:8000/"});
}