import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/business_app/services/services.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetupAccountPage extends StatefulWidget {
  @override
  _SetupAccountPageState createState() => _SetupAccountPageState();
}

class _SetupAccountPageState extends State<SetupAccountPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyStyles.of(context).colors.background1,
        body: SafeArea(
          child: Container(
            color: MyStyles.of(context).colors.background1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<User>(
                          builder: (context, user, _) {
                            return Container(
                              child: Text(
                                "Hello ${user.name ?? "John Doe"}!",
                                textAlign: TextAlign.center,
                                style: MyStyles.of(context).textThemes.h2,
                              )
                            );
                          }
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          child: Text(
                            "Almost there.",
                            textAlign: TextAlign.center,
                            style: MyStyles.of(context).textThemes.h3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 3,
                  child: Container(
                    // color: Colors.red,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StyleTextField(
                          controller: nameController,
                          placeholderText: "Enter Business Name",
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        StyleTextField(
                          controller: descriptionController,
                          placeholderText: "Enter Business Description",
                          maxLines: 6,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: Container(
                    alignment: Alignment.center,
                    child: Consumer<User>(
                      builder: (context, user, _) {
                        return AccentedActionButton(
                          width: 233,
                          height: 55,
                          text: "Continue",
                          onPressed: () async {
                            if (this.nameController.text.isEmpty) {
                              throw CustomException("You must enter a business name.");
                            }

                            await user.updateUserData(
                              name: this.nameController.text,
                              description: this.descriptionController.text
                            );
                          },

                          onSuccess: () async {
                            Navigator.of(context).popAndPushNamed("/dashboard");
                          },
                        );
                      }
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