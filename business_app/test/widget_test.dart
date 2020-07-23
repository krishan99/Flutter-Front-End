// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/business_app/services/services.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/user_app/services/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
void main() async {
  
  test("Test Sign In",
   () async {
      BusinessAppServer server = BusinessAppServer();

      expect(() async {
        // await server.signIn("roar@gmail.com");
      }, returnsNormally);
    }
  );
  test("Test Socket",
   () async {
     IO.Socket socket = IO.io(MyServer.path, <String, dynamic>{
        'transports': ['websocket'],
        'autoconnect': false,
        'extraHeaders': MyServer.headers
      });
      socket.connect();
      socket.emit('join', {'qid': 6});
      socket.on("update 6", (data) {
          print("hi");
      });
      
      await Future.delayed(Duration(days: 1));
    }
  );
}

