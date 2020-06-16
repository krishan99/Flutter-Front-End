import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/dashboard_page.dart';
import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/business_app/screens/queue_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
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
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}