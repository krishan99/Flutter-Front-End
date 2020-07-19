import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/business_app/screens/user_creation_pages/create_user_page.dart';
import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';

import 'package:business_app/business_app/screens/home_page.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget implements EntranceScreen {
  double height;
  LoginPage.height({this.height});

  @override
  Widget build(BuildContext context) {
    return CreateUserPage(
      height: height,
      customUserForm: Column(
        children: <Widget>[
        Container(child: StyleTextField.email(
          onChanged: (string) {
            print("$string");
          },
        )),
        SizedBox(height: 10,),
        Container(child: StyleTextField.password(
          onChanged: (string) {
            print("$string");
          },
        )),
      ]),
    );
  }
}
