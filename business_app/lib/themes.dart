import 'package:flutter/material.dart';

class MyStyles {
  static const lightMode = MyStyles._(colors: MyColors.lightMode, textThemes: MyTextThemes.lightMode);
  static const darkMode = MyStyles._(colors: MyColors.darkMode, textThemes: MyTextThemes.darkMode);

  static MyStyles of(BuildContext context) {
    switch (MediaQuery.of(context).platformBrightness) {
      case Brightness.light: 
        return MyStyles.lightMode;
        break;
      case Brightness.dark:
        return MyStyles.darkMode;
        break;
    }

    assert(false);
  }

  final MyColors colors;
  final MyTextThemes textThemes;

  const MyStyles._({this.colors, this.textThemes});
}

class MyColors {
  static const lightMode = const MyColors._(
    background1: Colors.white,
    background2: Color.fromRGBO(248, 248, 248, 1),
    accent: Color.fromRGBO(255, 83, 83, 1),
    secondary: Color.fromRGBO(98, 98, 98, 1),
    accentGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color.fromRGBO(255, 75, 43, 1),
        Color.fromRGBO(255, 65, 108, 1)
      ]
    )
  );

  static const darkMode = MyColors.lightMode;

  MyColors copyWith({Color background1, Color background2, Color accent, Color secondary, LinearGradient accentGradient}) {
    return MyColors._(
      background1: background1 ?? this.background1,
      background2: background2 ?? this.background2,
      accent: accent ?? this.accent, 
      accentGradient: accentGradient ?? this.accentGradient
      );
  }

  final Color background1;
  final Color background2;
  final Color accent;
  final Color secondary;
  final LinearGradient accentGradient;
  const MyColors._({this.background1, this.background2, this.accent, this.secondary, this.accentGradient}); 
}

class MyTextThemes {
  static const _fontFamily = "SanFrancisco";

  static const lightMode = MyTextThemes._(
    h1: TextStyle(fontSize: 47, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
    h2: TextStyle(fontSize: 40, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
    h3: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(98, 98, 98, 1), fontWeight: FontWeight.bold),
    h4: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(57, 57, 57, 1), fontWeight: FontWeight.w300),
    bodyText1: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(116, 116, 116, 1), fontWeight: FontWeight.bold),
    caption: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(103, 103, 103, 1), fontWeight: FontWeight.w300),
    button: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Colors.white, fontWeight: FontWeight.w300),
    subtitle1: TextStyle(fontSize: 20, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(98, 98, 98, 1), fontWeight: FontWeight.w300),
    placeholder: TextStyle(fontSize: 15, fontFamily: MyTextThemes._fontFamily, color: Color.fromRGBO(186, 186, 186, 1), fontWeight: FontWeight.w300),
  );

  static const darkMode = lightMode;

  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle bodyText1;
  final TextStyle bodyText2;
  final TextStyle caption;
  final TextStyle button;
  final TextStyle subtitle1;
  final TextStyle placeholder;

  const MyTextThemes._({this.h1, this.h2, this.h3, this.h4, this.bodyText1, this.bodyText2, this.caption, this.button, this.subtitle1, this.placeholder});
}