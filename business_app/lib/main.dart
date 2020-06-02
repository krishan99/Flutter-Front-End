import 'package:flutter/material.dart';
import 'package:business_app/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "SanFrancisco",
        //Using SanFrancisco because Helvetica's usWeightClass is off. Fix later.
        primaryColor: Color.fromRGBO(255, 83, 83, 1),
        secondaryHeaderColor: Color.fromRGBO(98, 98, 98, 1),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 47,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold),
          headline2: TextStyle(
              fontSize: 40,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold),
          headline3: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(98, 98, 98, 1),
              fontWeight: FontWeight.bold),
          headline4: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(57, 57, 57, 1),
              fontWeight: FontWeight.w300),
          bodyText1: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold),
          bodyText2: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(116, 116, 116, 1),
              fontWeight: FontWeight.bold),
          caption: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(103, 103, 103, 1),
              fontWeight: FontWeight.w300),
          button: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300
          ),
          subtitle1: TextStyle(
              fontSize: 20, color: Color.fromRGBO(98, 98, 98, 1), fontWeight: FontWeight.w300
          )
        ),
      ),
      home: HomePage(),
    );
  }
}
