import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

//class MyTextTheme extends TextTheme {
//  final TextStyle button1;
//  final TextStyle button2;
//  final TextStyle formField;
//  final TextStyle subtext;
//
//  MyTextTheme._({this.button1, this.button2, this.formField, this.subtext}) {
//    super.copyWith(
//      headline1: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 47, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w800),
//      headline2: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 40, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w800),
//      headline3: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(98, 98, 98, 1), fontWeight: FontWeight.w800),
//      headline4: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(57, 57, 57, 1), fontWeight: FontWeight.w600),
//      bodyText1: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w800),
//      bodyText2: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(116, 116, 116, 1), fontWeight: FontWeight.w800),
//      caption: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w600),
//    );
//  }
//
//  factory MyTextTheme() {
//    return new MyTextTheme._(
//      button1: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w600),
//      button2: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w600),
//      formField: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w600),
//      subtext: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w600),
//    );
//  }
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Color.fromRGBO(255, 83, 83, 1),
        backgroundColor: Colors.white,

        // Define the default font family.
        fontFamily: 'Helvetica Neue',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 47, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w800),
          headline2: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 40, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w800),
          headline3: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(98, 98, 98, 1), fontWeight: FontWeight.w800),
          headline4: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(57, 57, 57, 1), fontWeight: FontWeight.w600),
          bodyText1: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w800),
          bodyText2: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(116, 116, 116, 1), fontWeight: FontWeight.w800),
          caption: TextStyle(fontFamily: 'Helvetica Neue', fontSize: 20, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w600),
        ),
      ),
      home: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                child: Text("LiveSafe for Businesses", style: Theme.of(context).textTheme.headline1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
