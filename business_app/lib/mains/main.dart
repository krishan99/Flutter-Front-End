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

  runApp(
    MultiProvider(
      providers: [
            ChangeNotifierProvider<User>(create: (context) => mD.user,)
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
                return QueuePage(name: user.name ?? "John Doe",);
              } else {
                return HomePage();
              }
            },
          )
    );
  }
}
