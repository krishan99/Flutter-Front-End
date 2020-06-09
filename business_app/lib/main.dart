import 'package:business_app/style_elements.dart';
import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:business_app/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "SanFrancisco",
        //Using SanFrancisco because Helvetica's usWeightClass is off. Fix later.
      ),
      home: HomePage(),
    );
  }
}
