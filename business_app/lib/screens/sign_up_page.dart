import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:business_app/components/components.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget implements EntranceScreen {
  final double height;
  SignUpPage.height({this.height});
  SignUpPage({this.height});

  @override
  _SignUpPageState createState() => _SignUpPageState(height: this.height);

}

class _SignUpPageState extends State<SignUpPage> {
  final double height;

  _SignUpPageState({this.height}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
          child: Container(
            color: MyStyles.of(context).colors.background1,
            constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: MyStyles.of(context).textThemes.h2,
                          )),
                      SizedBox(height: 6,),
                      Container(
                        child: Text(
                          "EndLine Inc.",
                          textAlign: TextAlign.center,
                          style: MyStyles.of(context).textThemes.h3,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                            flex: 1,
                            child: StyleTextField(
                              placeholderText: "Enter Business Address",
                              onChanged: (string){print("$string");},
                            )
                        ),
                        SizedBox(height: 12,),
                        Flexible(
                            flex: 3,
                            child: StyleTextField(
                              placeholderText: "Enter Business Name",
                              onChanged: (string){
                                print("$string");
                              },
                            )
                        ),
                        SizedBox(height: 12,),
                        Flexible(
                            flex: 3,
                            child: StyleTextField(
                              placeholderText: "Enter Business Description", 
                              onChanged: (string){
                                print("$string");
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    alignment: Alignment.center,
                    child: AccentedActionButton(
                      width: 233,
                      height: 55,
                      text: "Continue",
                      onPressed: () => {
                        print("sign up")
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

