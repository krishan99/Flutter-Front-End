import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/user_creation_pages/user_creation_components.dart';
import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';

import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:provider/provider.dart';

class CreateUserPage extends StatefulWidget {
  final double height;
  Widget customUserForm;

  CreateUserPage({this.height, @required this.customUserForm});
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  //little hacky but should be fine as CreateUser Page should always be presented modally in production.
  bool get isModallyPresented {
    return widget.height != null;
  }

  User user;

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
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            constraints: BoxConstraints(
                maxHeight: widget.height ?? MediaQuery.of(context).size.height),
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
                        "Welcome Back!",
                        textAlign: TextAlign.center,
                        style: MyStyles.of(context).textThemes.h2,
                      )),
                      SizedBox(
                        height: 12,
                      ),
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
                            showErrorDialog(context,
                                title: "Sign In Error", body: error.toString());
                          });
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.loose,
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 300),
                    width: 269,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Or Create User With Email",
                            style: MyStyles.of(context).textThemes.bodyText2,
                          ),
                        ),
                        widget.customUserForm,
                        Container(
                          child: AccentedActionButton(
                            text: "Continue",
                            onPressed: () => {print("sign up")},
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Text(
                              "forgot your password",
                              style:
                                  MyStyles.of(context).textThemes.placeholder,
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
