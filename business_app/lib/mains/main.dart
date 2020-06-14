import 'package:business_app/model_data.dart';
import 'package:business_app/views/dashboard_page.dart';
import 'package:business_app/views/queue_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:business_app/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  final mD = ModelData();

  mD.queues.add(
    Queue(
        name: "Outdoor Queue",
        state: QueueState.active,
        code: "54-24"
    )
  );

  runApp(
    MultiProvider(
      providers: [
            ChangeNotifierProvider.value(value: mD.user),
            ChangeNotifierProvider.value(value: mD.queues)
      ],
      child: MyApp()
    )
  );
      
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
        title: 'EndLine',
        home: Consumer<User>(
            builder: (context, user, _) {
              if (user.isLoggedIn) {
                return DashboardPage();
              } else {
                return HomePage();
              }
            },
          )
    );
  }
}
