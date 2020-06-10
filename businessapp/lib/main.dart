import 'package:business_app/home_page.dart';
import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dashboard_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      // home: DashboardPage(name: "John Doe"),
    );


  }
}
