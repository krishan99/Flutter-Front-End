import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:business_app/style_elements.dart';

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
      body: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: height),
                    child: Column(
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
                                  style: MyStyles.of(context).textThemes.h2,
                                ),
                              ),
                            ],
                          ),
                        ),
//              Container(
//                  child: GoogleSignInButton()
//              ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            width: 300,
//                        constraints: BoxConstraints(
//                            maxHeight: 400
//                        ),
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
                                    child: StyleTextField(maxLines: 2, placeholderText: "Enter Business Name", onChanged: (string){print("$string");},)
                                ),
                                SizedBox(height: 12,),
                                Flexible(
                                    flex: 3,
                                    child: StyleTextField(maxLines: 2, placeholderText: "Enter Business Description", onChanged: (string){print("$string");},)
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
                            child: ActionButton(
                              width: 233,
                              height: 55,
                              child: Text(
                                "Continue",
                                style: MyStyles.of(context).textThemes.button,
                              ),
                              gradient: MyStyles.of(context).colors.accentGradient,
                              onPressed: () => {print("sign up")},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

