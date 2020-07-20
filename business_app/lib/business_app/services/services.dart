import 'package:business_app/services/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BusinessAppServer extends MyServer {
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

  //TODO: Use firebase Token ID instead.
  Future<void> signIn(String email) async {
    await post(
      "api/v1/test",
      body: <String, String>{
        "email": email,
      }
    ); 
  }

  Future<List> getListofQueues() async {
    Map<String, dynamic> body = await get("api/v1/queue/retrieve_all");
    return body["queues"];
  }

  //TODO: Shouldn't this just return a Queue object?
  Future<Map<String, dynamic>> makeQueue(String name, String description) async {
    return await post(
      "api/v1/queue/make",
      body: <String, String>{
        "qname": name,
        "description": description,
      }
    );
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

