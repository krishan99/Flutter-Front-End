// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:business_app/business_app/services/services.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/user_app/services/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  
  test("Test Sign In",
   () async {
      BusinessAppServer server = BusinessAppServer();

      expect(() async {
        await server.signIn("roar@gmail.com");
      }, returnsNormally);
    }
  );
  test("Test Getform",
   () async {

      UAppServer server = UAppServer();
      var response = await server.post(
        "api/v1/queue/user/getform",
        body: <String, String> {
          "code": '3418',
      });
      print("hi");
    }
  );
}

