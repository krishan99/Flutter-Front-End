import 'package:flutter/material.dart';
import 'package:business_app/style_elements.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                    "EndLine for Businesses",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  )),
              Container(
                width: 230,
                height: 100,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(
                          "https://image.shutterstock.com/image-vector/people-waiting-long-queue-counter-260nw-1065200126.jpg"),
                    )),
              ),
              Column(
                children: <Widget>[
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
                  SizedBox(height: 15,),
                  Container(
                    child: ActionButton(
                      width: 233,
                      height: 55,
                      child: Text(
                        "Log In",
                        style: Theme.of(context).textTheme.button,
                      ),
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () => {print("Log In")},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}