import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';

class BusinessAppServer extends MyServer {
  //TODO: Use firebase Token ID instead.
  Future<MyServerResponse> signIn(String email) async {
    return post(
      "/api/v1/test",
      body: <String, String>{
        "email": email,
      }
    ); 
  }

  Future<MyServerResponse> createQueue({@required String name, String description = ""}) async {
    return post(
      "/api/v1/qudeue/make", 
      body: {
        "qname": name,
        "description": description
      }
    );
  }

  Future<Queues> getQueues() async {
    final response = await get(
      "/api/v1/queue/retrieve_all"
    );

    return Queues.fromMap(response.body);
  }

  BusinessAppServer({String path = "http://0.0.0.0:8000"}) : super(path: path);
}

