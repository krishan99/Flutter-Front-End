import 'dart:async';
import 'dart:convert';

//When this file gets to big, split into multiple files.

import 'package:business_app/services/services.dart';
import 'package:business_app/user_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ModelData {
  User user;
  UAppServer server;
  QueueHandler queueHandler;

  ModelData() {
    user = User();
    server = UAppServer(path: "http://0.0.0.0:8000/");
    queueHandler = QueueHandler(server: server);
  }
}

class QueueHandler {
  UAppServer server;
  StreamController _queueReqsController;
      
  Stream<ApiResponse<QueueReqs>> get queueReqsStream {
    return _queueReqsController.stream;
  }

  StreamSink<ApiResponse<QueueReqs>> get queueReqsSink {
    return _queueReqsController.sink;
  }

  updateQueueReqs({@required String code}) async {
    try {
      QueueReqs queueReqs = await server.getQueueInfo(code: code);
      queueReqsSink.add(ApiResponse.completed(queueReqs));
    } catch (e) {
      queueReqsSink.add(ApiResponse.error(e.toString()));
    }
  }

  QueueHandler({@required UAppServer server}) {
    this.server = server;
    this._queueReqsController = StreamController<ApiResponse<QueueReqs>>();
  }

  dispose() {
    _queueReqsController?.close();
  }
}

class QueueReqs {
  final int qid;
  final String code;
  final bool needsName;
  final bool needsPhoneNumber;

  QueueReqs({
    this.qid,
    this.code,
    this.needsName,
    this.needsPhoneNumber,
  });

  static QueueReqs fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return QueueReqs(
      qid: map['qid'] as int,
      code: map['qcode'] as String,
      needsName: (map.containsKey("Name: ")),
      needsPhoneNumber: map.containsKey('Phone: '),
    );
  }

  static QueueReqs fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'QueueReqs(qid: $qid, needsName: $needsName, needsPhoneNumber: $needsPhoneNumber)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is QueueReqs &&
      o.qid == qid &&
      o.needsName == needsName &&
      o.needsPhoneNumber == needsPhoneNumber;
  }

  @override
  int get hashCode => qid.hashCode ^ needsName.hashCode ^ needsPhoneNumber.hashCode;
}

class User extends ChangeNotifier {
  String name;
  String phoneNumber;
  String notes;
}

