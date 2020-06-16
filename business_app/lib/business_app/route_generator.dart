import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/dashboard_page.dart';
import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/business_app/screens/queue_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:business_app/route_generator.dart';

class BAppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            final user = Provider.of<User>(context, listen: false);
            if (user.isLoggedIn) {
              return DashboardPage();
            } else {
              return HomePage();
            }
          }
        );

      case '/queue':
        // Validation of correct data type
        return MaterialPageRoute(
          builder: (context) {
            final user = Provider.of<User>(context, listen: false);
            assert(user.isLoggedIn);
            Queue queue = args as Queue;
            return ChangeNotifierProvider.value(
              value: queue,
              child: Consumer<Queue>(
                builder: (context, queue, _) {
                  return QueuePage(queue: queue,);
                }
              )
            );
          }
        );
        // return _errorRoute();
        
      default:
        assert(false);
    }
  }
}