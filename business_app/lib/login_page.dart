import 'package:flutter/material.dart';
import 'package:business_app/style_elements.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                            "Welcome Back!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2,
                          )
                      ),
                      SizedBox(height: 12,),
                      Container(
                        child: Text(
                          "Happy customers are the best advertising money can buy.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4,
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
                            style: Theme.of(context).textTheme.bodyText2,
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
                              style: Theme.of(context).textTheme.button,
                            ),
                            gradient: MyGradients.primaryGradient,
                            onPressed: () => {print("sign up")},
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Text(
                              "forgot your password",
                              style: Theme.of(context).textTheme.subtitle2,
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
  Function onPressed;

  GoogleSignInButton({this.onPressed}) : super();

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
                  style: Theme.of(context)
                      .textTheme
                      .headline4
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
