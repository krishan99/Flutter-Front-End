import 'package:business_app/services/services.dart';

class BusinessAppServer extends MyServer {
  //TODO: Use firebase Token ID instead.
  Future<MyServerResponse> signIn(String email) async {
    return post(
      "api/v1/test",
      body: <String, String>{
        "email": email,
      }
    ); 
  }

  BusinessAppServer({String path = "http://0.0.0.0:8000/"}) : super(path: path);
}

