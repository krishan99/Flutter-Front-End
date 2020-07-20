import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/business_app/screens/user_creation_pages/user_creation_components.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/utils.dart';

class CreateUserPage extends StatefulWidget {
  final double height;
  final String title;
  final String subtext;
  final String buttonText;
  final Future<void> Function() onContinue;
  Widget customUserForm;

  CreateUserPage({
    Key key,
    this.height,
    @required this.title,
    this.subtext = "Happy customers are the best advertising money can buy.",
    this.buttonText = "Continue",
    this.onContinue,
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

  ApiResponse<String> formState;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();    

  //   if (user.isLoggedIn && isModallyPresented) {
  //     Navigator.pop(context);
  //   }
  // }

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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: MyStyles.of(context).textThemes.h2,
                      )
                    ),
                    SizedBox(
                      height: 12,
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
                Center(
                  child: Consumer<User>(
                    builder: (context, user, _) {
                      return GoogleSignInButton(
                        onPressed: () {
                          user.signInWithGoogle().catchError((error) {
                            showErrorDialog(context,
                                title: "Sign In Error", body: error.toString());
                          });
                        },
                      );
                    }
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 300),
                  width: 269,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Or Use Email",
                          style: MyStyles.of(context).textThemes.bodyText2,
                        ),
                      ),
                      Container(
                        // color: Colors.yellow,                          
                        child: widget.customUserForm
                      ),
                      Column(
                        children: [
                          Container(
                            child: AccentedActionButton(
                              text: widget.buttonText,
                              onPressed: () async {
                                final response = await ApiResponse.fromFunction(widget.onContinue);
                                setState(() {
                                  this.formState = response;
                                });
                              },
                            ),
                          ),
                          if (this.formState != null)
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text(this.formState.message, style: MyStyles.of(context).textThemes.errorSubText)
                            )
                        ],
                      ),

                      // Material(
                      //   color: Colors.transparent,
                      //   child: InkWell(
                      //     child: Text(
                      //       "forgot your password",
                      //       style:
                      //           MyStyles.of(context).textThemes.placeholder,
                      //     ),
                      //   ),
                      // )
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
