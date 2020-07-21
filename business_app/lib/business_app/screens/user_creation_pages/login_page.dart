import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/business_app/screens/user_creation_pages/create_user_page/create_user_page.dart';
import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/components/components.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget implements EntranceScreen {
  final double height;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage.height({this.height});

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, _) {
        return CreateUserPage(
          height: height,
          title: "Welcome Back!",
          onContinue: () async {
            final ApiResponse response = await ApiResponse.fromFunction(
              () async {
                await user.signIn(
                  email: this.emailController.text,
                  password: this.passwordController.text
                );
              }
            );
            
            if (response.isSuccess && user.isLoggedIn) {
              Navigator.of(context).popAndPushNamed("/dashboard");
            }
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
            ]
          )
        );
      }
    );
  }
}
