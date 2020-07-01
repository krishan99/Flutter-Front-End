import 'package:business_app/services/services.dart';

class BusinessAppServer extends MyServer {
  //TODO: Use firebase Token ID instead.
  Future<MyServerResponse> signIn(String email) async {
    return post(
      "api/v1/test",
      body: <String, String>{
        "email": "pizza@gmail.com",
      }
    ); 
  }

  Future<List<dynamic> > getListofQueues() async {
    MyServerResponse temp = await get("api/v1/queue/retrieve_all");
    return temp.body["queues"];
  }

  Future<Map<String, dynamic> > makeQueue(String name, String description) async {
    MyServerResponse temp = await post(
      "api/v1/queue/make",
      body: <String, String>{
        "qname": name,
        "description": description,
      }
    );
    return temp.body;
  }

  BusinessAppServer({String path = "http://0.0.0.0:8000/"}) : super(path: path);
}

