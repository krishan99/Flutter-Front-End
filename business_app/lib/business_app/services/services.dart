import 'package:business_app/services/services.dart';

class BusinessAppServer extends MyServer {
  //TODO: Use firebase Token ID instead.
  signIn(String email) async {
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

  deleteQueue(int id) async {
    await post(
      "api/v1/queue/delete",
      body: <String, int>{
        "qid": id,
      }
    );
  }

  BusinessAppServer({String path = "http://0.0.0.0:8000/"}) : super(path: path);
}

