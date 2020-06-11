import 'package:business_app/model_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:business_app/views/home_page.dart';
import 'package:business_app/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    final ModelData mD = ModelData();

    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      // home: DashboardPage(name: "John Doe"),
    );


  }
}
