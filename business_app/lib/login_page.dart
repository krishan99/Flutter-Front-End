import 'package:flutter/material.dart';

import 'package:business_app/home_page.dart';
import 'package:business_app/style_elements.dart';
import 'package:business_app/themes.dart';

class LoginPage extends StatefulWidget implements EntranceScreen {
  final double height;
  LoginPage.height({this.height});
  LoginPage({this.height});
  @override
  _LoginPageState createState() => _LoginPageState(height: this.height);
}

class _LoginPageState extends State<LoginPage> {
  final double height;
  _LoginPageState({this.height}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                          "Welcome Back!",
                          textAlign: TextAlign.center,
                          style: MyStyles.of(context).textThemes.h2,
                        )
                    ),
                    SizedBox(height: 12,),
                    Container(
                      child: Text(
                        "Happy customers are the best advertising money can buy.",
                        textAlign: TextAlign.center,
                        style: MyStyles.of(context).textThemes.h4,
                      ),
                    ),
                  ],
                ),
              ),

//              Container(
//                  child: GoogleSignInButton()
//              ),
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GoogleSignInButton(
                      onPressed: () {
                        print("sah");
                      },
                    ),
                    SizedBox(height: 10,),
                    GoogleSignInButton(
                      onPressed: () {
                        print("sah");
                      },
                    ),
                  ],
                ),
              ),

              Flexible(
                flex: 7,
                fit: FlexFit.loose,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 300
                  ),
                  width: 269,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Or Login With Email",
                          style: MyStyles.of(context).textThemes.bodyText2,
                        ),
                      ),
                      Container(
                          child: StyleTextField(placeholderText: "Email...", onChanged: (string){print("$string");},)
                      ),
                      Container(
                          child: StyleTextField(placeholderText: "Password...", onChanged: (string){print("$string");},)
                      ),
                      Container(
                        child: ActionButton(
                          width: 233,
                          height: 55,
                          child: Text(
                            "Sign Up",
                            style: MyStyles.of(context).textThemes.button,
                          ),
                          gradient: MyStyles.of(context).colors.accentGradient,
                          onPressed: () => {print("sign up")},
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: Text(
                            "forgot your password",
                            style: MyStyles.of(context).textThemes.placeholder,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final Function onPressed;
  
  const GoogleSignInButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/google_logo.png"),
                  height: 24.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: MyStyles.of(context)
                      .textThemes
                      .h4
                      .copyWith(fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
