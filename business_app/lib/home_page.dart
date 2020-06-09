import 'package:business_app/sign_up_page.dart';
import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:business_app/style_elements.dart';
import 'login_page.dart';

enum EntranceScreenType { signUp, logIn }

abstract class EntranceScreen extends Widget {
  final height;
  EntranceScreen.height({this.height});
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _showScreenModally<T extends EntranceScreen>(T screen) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Container(
                height: screen.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: screen);
          });
    }

    _showScreenModallyWithType({EntranceScreenType screenType}) {
      final height = MediaQuery.of(context).size.height * 0.9;
      switch (screenType) {
        case EntranceScreenType.logIn:
          _showScreenModally(LoginPage.height(height: height));
          break;
        case EntranceScreenType.signUp:
          _showScreenModally(SignUpPage.height(
            height: height,
          ));
          break;
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                      "EndLine for Businesses",
                      textAlign: TextAlign.center,
                      style: MyStyles.of(context).textThemes.h1,
                    )),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: 230,
                      height: 100,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do",
                        textAlign: TextAlign.center,
                        style: MyStyles.of(context).textThemes.h4,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: NetworkImage(
                        "https://image.shutterstock.com/image-vector/people-waiting-long-queue-counter-260nw-1065200126.jpg"),
                  )),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: 233,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: ActionButton(
                            child: Text(
                              "Sign Up",
                              style: MyStyles.of(context).textThemes.button,
                            ),
                            gradient: MyStyles.of(context).colors.accentGradient,
                            onPressed: () => {
                                  _showScreenModallyWithType(
                                      screenType: EntranceScreenType.signUp)
                                }),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: ActionButton(
                          child: Text(
                            "Log In",
                            style: MyStyles.of(context).textThemes.button,
                          ),
                          color: MyStyles.of(context).colors.secondary,
                          onPressed: () => {
                            _showScreenModallyWithType(
                                screenType: EntranceScreenType.logIn)
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
