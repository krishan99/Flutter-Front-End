import 'dart:convert';

import 'package:business_app/services/services.dart';
import 'package:business_app/user_app/models/models.dart';
import 'package:flutter/material.dart';

class UAppServer extends MyServer {
  //TODO: Use firebase Token ID instead.
  
  Future<QueueReqs> getQueueInfo({@required String code}) async {
    final response = await post(
      "/v1/queue/user/getform",
      body: <String, String> {
        "code": code,
      });
    
    return QueueReqs.fromJson(response.toString());

    // return QueueReqs(code: "43-4", qid: 1, needsName: true, needsPhoneNumber: true);
  }

  addToQueue({@required int qid, String name = "John Doe", String phoneNumber = ""}) async {
    post(
      "/api/v1/queue/user/postform",
      body: <String, String> {
        "qid": qid.toString(),
        "name": name,
        "phone": phoneNumber,
      }
    );
  }

  UAppServer({String path = "http://0.0.0.0:8000/"}) : super(path: path);
}