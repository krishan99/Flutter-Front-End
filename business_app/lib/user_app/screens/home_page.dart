import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: MyStyles.of(context).colors.accentGradient
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
              child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("EndLine", style: MyStyles.of(context).textThemes.h1.copyWith(color: Colors.white),),
                          SizedBox(height: 20),
                          Container(
                            color: Colors.transparent,
                            constraints: BoxConstraints(maxWidth: 250),
                            child: StyleTextField(
                              placeholderText: "Enter Pin...",
                              maxLines: 1,
                              
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(15),
                            constraints: BoxConstraints(maxWidth: 200),
                            child: ActionButton(
                              color: Color.fromRGBO(46, 46, 46, 1),
                              child: Text(
                                "Submit",
                                style: MyStyles.of(context).textThemes.buttonActionText1,)
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Text("Need Help?", style: MyStyles.of(context).textThemes.h3.copyWith(color: Colors.white),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.bottomCenter,
                      child: Text("Business Owner?", style: MyStyles.of(context).textThemes.h3.copyWith(color: Colors.white),)
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}