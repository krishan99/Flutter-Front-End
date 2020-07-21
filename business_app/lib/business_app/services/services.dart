import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BusinessAppServer extends MyServer {
  static const String _tokenHeader = "Authorization";

  static IO.Socket socket = IO.io('http://127.0.0.1:8000', <String, dynamic>{
    'transports': ['websocket'],
    'autoconnect': false,
    'extraHeaders': MyServer.headers
  });
  static int currentRoom = -1;
  bool connectSocket() {
    socket.connect();
    socket.on('connect', (_) {
        print('Connected to socket');
      });
    return true;
  }

  static bool joinRoom(int qid) {
    if(qid == currentRoom) return true;
    socket.emit('join', {'qid': qid});
    currentRoom = qid;
    // check if succesful
    return true;
  }

  static void leaveRoom() {
    if(currentRoom != -1) socket.emit('leave', {'qid': currentRoom});
    currentRoom = -1;
  }

  Future<void> signIn({@required String token}) async {
    _setToken(token);
    
    await post(
      "api/v1/account/signin",
      body: <String, String>{}
    ); 
  }

  Future<void> signUp({@required String token, String name, String description}) async {
    _setToken(token);

    await post(
      "api/v1/account/signup",
      body: <String, String>{
        "name": name ?? "",
        "description": description ?? ""
      }
    ); 
  }

  void _setToken(String token) {
    MyServer.headers[_tokenHeader] = token;
  }

  Future<void> updateUserData({@required String name, @required String description}) async {
    await post(
      "api/v1/account/update",
      body: <String, String> {
        "name": name,
        "description": description
      }
    );
  }
  

  Future<List<Queue>> getListofQueues() async {
    Map<String, dynamic> body = await get("api/v1/queue/retrieve_all");
    return (body["queues"] as List).map(
      (queueMapObject) => Queue.fromMap(queueMapObject as Map<String, dynamic>)
    ).toList();
  }

  Future<Queue> makeQueue(String name, String description) async {
    Map<String, dynamic> body = await post(
      "api/v1/queue/make",
      body: <String, String>{
        "qname": name,
        "description": description,
      }
    );

    return Queue.fromMap(body);
  }

  Future<void> deleteQueue(int id) async {
    await post(
      "api/v1/queue/delete",
      body: <String, int>{
        "qid": id,
      }
    );
  }

  Future<void> deletePerson(int id, int person_id) async{
    await post(
      "api/v1/queue/manage/pop",
      body: <String, int>{
        "qid": id,
        "id": person_id,
      }
    );
  }

  BusinessAppServer({String path = "http://0.0.0.0:8000/"}) : super(path: path);
}

