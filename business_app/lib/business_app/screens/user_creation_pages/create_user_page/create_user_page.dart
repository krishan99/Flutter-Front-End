import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/business_app/screens/user_creation_pages/create_user_page/user_creation_components.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:toast/toast.dart';

class CreateUserPage extends StatefulWidget {
  final double height;
  final String title;
  final String subtext;
  final String buttonText;
  final String googleSignInText;
  final Future<void> Function() onContinue;
  final Function onSuccess;
  Widget customUserForm;

  CreateUserPage({
    Key key,
    this.height,
    @required this.title,
    this.subtext = "Happy customers are the best advertising money can buy.",
    this.buttonText = "Continue",
    this.googleSignInText = "Sign In With Google",
    this.onContinue,
    this.onSuccess,
    this.customUserForm,
  }) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  //little hacky but should be fine as CreateUser Page should always be presented modally in production.
  bool get isModallyPresented {
    return widget.height != null;
  }

  static double spacing = 12;

  String erroMessage;

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
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                        child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: MyStyles.of(context).textThemes.h2,
                    )),
                    SizedBox(
                      height: spacing,
                    ),
                    Container(
                      child: Text(
                        widget.subtext,
                        textAlign: TextAlign.center,
                        style: MyStyles.of(context).textThemes.h4,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Consumer<User>(builder: (context, user, _) {
                      return GoogleSignInButton(
                        text: widget.googleSignInText,
                        onPressed: () {
                          user.signInWithGoogle().catchError((error) {
                            Toast.show(error.toString(), context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          });
                        },
                      );
                    }),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 330),
                  padding: EdgeInsets.all(20),
                  // width: 269,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Or Use Email",
                          style: MyStyles.of(context).textThemes.bodyText2,
                        ),
                      ),
                      SizedBox(
                        height: spacing,
                      ),
                      Container(
                          // color: Colors.yellow,
                          child: widget.customUserForm),
                      SizedBox(
                        height: spacing,
                      ),
                      Column(
                        children: [
                          Container(
                            child: AccentedActionButton(
                              text: widget.buttonText,
                              onPressed: () async {
                                try {
                                  await widget.onContinue();
                                  setState(() {
                                    this.erroMessage = null;
                                  });
                                } catch (error) {
                                  setState(() {
                                    this.erroMessage = error.toString();
                                  });
                                  throw error;
                                }
                              },
                              onSuccess: widget.onSuccess,
                            ),
                          ),
                          if (erroMessage != null)
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                erroMessage,
                                textAlign: TextAlign.center,
                                style: MyStyles.of(context).textThemes.errorSubText
                              )
                            )
                        ],
                      ),
                      SizedBox(
                        height: spacing,
                      ),
                    ],
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
