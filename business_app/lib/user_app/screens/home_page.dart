import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingButton extends StatelessWidget {

  final Color color;
  final Widget defaultWidget;
  final Function onPressed;

  const LoadingButton({Key key, this.color, this.defaultWidget, this.onPressed}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      color: color ?? Colors.grey[900],
      child: Container(
        child: ProgressButton(
          defaultWidget: defaultWidget,
          type: ProgressButtonType.Flat,
          borderRadius: 1,
          animate: false,
          progressWidget: JumpingDotsProgressIndicator(
            fontSize: 20,
            color: Colors.white,
          ),
          onPressed: onPressed
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TappableGradientScaffold(
      body: Stack(
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
                  color: Colors.transparent,
                  constraints: BoxConstraints(maxWidth: 200),
                  child: LoadingButton(
                    defaultWidget: Text("Submit", style: MyStyles.of(context).textThemes.buttonActionText2),
                    onPressed: () async {
                      print("Roar");
                      return () async {

                      };
                    },
                  )

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
    );
  }
}