import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:business_app/user_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinQueuePage extends StatefulWidget {
  @override
  _JoinQueuePageState createState() => _JoinQueuePageState();
}

class _JoinQueuePageState extends State<JoinQueuePage> {
  @override
  Widget build(BuildContext context) {
    return TappableGradientScaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 340,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "EndLine",
                    style: MyStyles.of(context).textThemes.h1.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Consumer<User>(
                    builder: (context, user, _) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyStyles.of(context).colors.accent
                          ),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            user.qcode ?? "Invalid qCode",
                            textAlign: TextAlign.center,
                            style: MyStyles.of(context).textThemes.bodyText2.copyWith(color: Colors.white),
                          )
                        ),
                      );
                    },
                  ),
                  Text(
                    "Join Queue for EndLine",
                    style: MyStyles.of(context).textThemes.h3.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  StyleTextField(placeholderText: "Full Name"),
                  StyleTextField(placeholderText: "Phone Number"),
                  StyleTextField(placeholderText: "Notes"),
                  
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}