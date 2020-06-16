import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/user_app/screens/join_queue_page.dart';
import 'package:flutter/material.dart';

class UAppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          }
        );
      
      case '/join_queue':
        return MaterialPageRoute(
          builder: (context) {
            return JoinQueuePage();
          }
        );
      default:
        assert(false);
    }
  }
}