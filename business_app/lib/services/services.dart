import 'dart:convert';

import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' as Foundation;

class CustomException implements Exception {
  String cause;
  
  @override
  String toString() {
    return cause;
  }

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

class ServerException extends MyServerException {
  ServerException(String cause) : super(cause);
}

class MyServer {
  final path;
  static const Duration timeout = Duration(seconds: Foundation.kDebugMode ? 10 : 10);

  static Map<String, String> _headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
  };
  static Map<String, String> get headers => _headers;

  String _getURL({@required String route}) {
    return "$path$route";
  }

  Future<Map<String, dynamic>> post(String route, {@required Map body}) async {
    final url = _getURL(route: route);

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(body)
    ).timeout(timeout);

    updateCookie(response);

    return getMap(response);
  }

  Future<Map<String, dynamic>> get(String route) async {
    final url = _getURL(route: route);
    final response = await http.get(
      url,
      headers: _headers,
    ).timeout(timeout);
    
    updateCookie(response);

    return getMap(response);
  }

  Map<String, dynamic> getMap(http.Response r) {
    if (r.statusCode == 500) {
      throw ServerException("Server Error");
    }
    
    final body = jsonDecode(r.body);

    if (r.statusCode == 200) {
      return body;
    }

    final message = body['message'] as String;

    switch (r.statusCode) {
      case 403:
        print(message);
        throw ForbiddenException(message);
      case 405:
        print(message);
        throw JsonEncodingException(message);
      case 404:
        print(message);
        throw NotFoundException(message);
      default:
        throw Exception(message);
    }
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  MyServer({this.path});
}

class ApiResponse<T> {
  Status status;
  T data;
  String message;

  bool get isError {
    return status == Status.ERROR;
  }

  bool get isSuccess {
    return status == Status.COMPLETED;
  }
  
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;
  
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  static Future<ApiResponse<T>> fromFunction<T>(Future<T> Function() function) async {
    try {
      T value = await function();
      return ApiResponse.completed(value);
    } catch (error) {
      return ApiResponse.error(error.toString());
    }
  }
}

enum Status { LOADING, COMPLETED, ERROR }