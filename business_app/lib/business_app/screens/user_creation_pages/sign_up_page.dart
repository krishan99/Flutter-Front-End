import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/user_creation_pages/create_user_page.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';

import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget implements EntranceScreen {
  double height;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  SignUpPage.height({this.height});

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, _) {
        return CreateUserPage(
          height: height,
          title: "Sign Up",
          googleSignInText: "Sign Up With Google",
          onContinue: () async {
            if (passwordController.text != checkPasswordController.text) {
              throw CustomException("passwords do not match");
            }

            await user.signUp(email: null, password: passwordController.text);
          },
          customUserForm: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(child: StyleTextField.email(
                controller: emailController,
              )),
              SizedBox(height: 10,),
              StyleTextField.password(
                controller: passwordController,
              ),
              SizedBox(height: 10,),
              StyleTextField.password(
                controller: checkPasswordController,
                paceholderText: "Retype Password...",
              ),
            ]
          )
        );
      }
    );
  }
}
