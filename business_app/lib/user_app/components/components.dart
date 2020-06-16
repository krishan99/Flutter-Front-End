import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';

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
