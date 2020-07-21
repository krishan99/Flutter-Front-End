import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/business_app/screens/add2_queue_page.dart';
import 'package:business_app/business_app/screens/dashboard_page.dart';
import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/business_app/screens/queue_page.dart';
import 'package:business_app/business_app/screens/create_queue_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BAppRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            final user = Provider.of<User>(context, listen: true);
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
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: queue),
                ChangeNotifierProvider.value(value: queue.people)
              ],
              child: QueuePage(queue: queue,)
            );
          }
        );
        // return _errorRoute();
        case '/createQueue':
          return MaterialPageRoute( 
           builder: (context) {
            AllQueuesInfo QueuesInfo = args as AllQueuesInfo;
            return CreateQueue(QueuesInfo);
          }
          );
        
         case '/add2Queue':
          return MaterialPageRoute( 
           builder: (context) {
            Queue queue = args as Queue;
            return Add2Queue(queue);
          }
          );
      default:
        assert(false);
    }
  }
}