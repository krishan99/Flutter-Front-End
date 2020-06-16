import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:progress_indicators/progress_indicators.dart';

class TappableGradientScaffold extends StatelessWidget {
  final Widget body;

  const TappableGradientScaffold({Key key, @required this.body}) : super(key: key);

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
                child: body
              )
            ),
          ),
        ),
      ),
    );
  }
}

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