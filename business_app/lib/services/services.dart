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
  Map<String, dynamic> body;
  Map<String, dynamic> get data => body;

  int _statusCode;
  int get statusCode => _statusCode;

  String get errorMessage {
    if (body.containsKey("message")) {
      return body["message"] as String;
    } else {
      return null;
    }
  }

  dynamic operator [](String key) {
    return body[key];
  }

  MyServerResponse(http.Response r) {
    this.body = jsonDecode(r.body);
    this._statusCode = r.statusCode;
  }
}

class MyServer {
  final path;

  static Map<String, String> _headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
  };

  String _getURL({@required String route}) {
    return "$path$route";
  }

  Future<MyServerResponse> post(String route, {@required Map body}) async {
    final url = _getURL(route: route);

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(body)
    );
    updateCookie(response);

    return _checkHttpResponse(response);
  }

  Future<MyServerResponse> get(String route) async {
    final url = _getURL(route: route);
    final response = await http.get(
      url,
      headers: _headers,
    );
    updateCookie(response);

    return _checkHttpResponse(response);
  }

  MyServerResponse _checkHttpResponse(http.Response response) {
    final myServerResponse = MyServerResponse(response);
    _checkResponse(myServerResponse);

    return myServerResponse;
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  _checkResponse(MyServerResponse response) {
    switch (response.statusCode) {
      case 200:
        return;
      case 403:
        throw ForbiddenException(response.errorMessage);
      case 405:
        throw JsonEncodingException(response.errorMessage);
      case 404:
        throw NotFoundException(response.errorMessage);
      default:
        throw Exception(response.errorMessage);
    }
  }

  MyServer({this.path});
}

class ApiResponse<T> {
  Status status;
  T data;
  String message;
  
ApiResponse.loading(this.message) : status = Status.LOADING;
ApiResponse.completed(this.data) : status = Status.COMPLETED;
ApiResponse.error(this.message) : status = Status.ERROR;
  
@override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }