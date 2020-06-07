import 'package:flutter/material.dart';
import 'package:business_app/style_elements.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2,
                          )),
                      SizedBox(height: 6,),
                      Container(
                        child: Text(
                          "EndLine Inc.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2,
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
                    constraints: BoxConstraints(
                      maxHeight: 400
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                            child: StyleTextField(
                              placeholderText: "Enter Business Address",
                              onChanged: (string){print("$string");},
                            )
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          flex: 3,
                            child: StyleTextField(maxLines: 2, placeholderText: "Enter Business Name", onChanged: (string){print("$string");},)
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          flex: 3,
                            child: StyleTextField(maxLines: 2, placeholderText: "Enter Business Description", onChanged: (string){print("$string");},)
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: ActionButton(
                      width: 233,
                      height: 55,
                      child: Text(
                        "Continue",
                        style: Theme.of(context).textTheme.button,
                      ),
                      gradient: MyGradients.primaryGradient,
                      onPressed: () => {print("sign up")},
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

