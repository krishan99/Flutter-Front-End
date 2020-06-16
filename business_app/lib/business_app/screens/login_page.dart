
import 'package:business_app/business_app/models/models.dart';
import 'package:flutter/material.dart';

import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget implements EntranceScreen {
  final double height;

  LoginPage.height({this.height});
  LoginPage({this.height});
  @override
  _LoginPageState createState() => _LoginPageState(height: this.height);
}

class _LoginPageState extends State<LoginPage> {

  //little hacky but should be fine as Login Page should always be presented modally in production.
  bool get isModallyPresented {
    return height != null;
  }

  double height;
  User user;

  _LoginPageState({double height}) {
    this.height = height;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<User>(context);

    if (user.isLoggedIn && isModallyPresented) {
        Navigator.pop(context);
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
          child: Container(
            constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                            "Welcome Backk!",
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
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GoogleSignInButton(
                        onPressed: () {
                          user.signInWithGoogle().catchError((error) {
                            showDialog(
                               context: context, 
                               builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Sign In Error"),
                                  content: new Text(error.toString()),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                      child: new Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          });
                        },
                      )
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
                            child: StyleTextField.type(
                              type: StyleTextFieldType.email,
                              onChanged: (string) {
                                print("$string");
                              },
                            )
                        ),
                        Container(
                            child: StyleTextField.type(
                              type: StyleTextFieldType.password, 
                              onChanged: (string) {
                                print("$string");
                              },
                            )
                        ),
                        Container(
                          child: ActionButton(
                            width: 233,
                            height: 55,
                            child: Text(
                              "Sign Up",
                              style: MyStyles.of(context).textThemes.buttonActionText1,
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
