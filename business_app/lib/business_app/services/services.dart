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

  BusinessAppServer({String path = "http://0.0.0.0:8000/"}) : super(path: path);
}

