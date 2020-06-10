import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Color color;
  final double width;
  final double height;
  final Function onPressed;

  const ActionButton({
    Key key,
    @required this.child,
    this.gradient,
    this.color,
    this.width = 233,
    this.height = 55,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0.0, 3),
              blurRadius: 6,
            )
          ],
          borderRadius: BorderRadius.circular(30)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

class AccentedActionButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Function onPressed;

  const AccentedActionButton({
    Key key,
    @required this.text,
    this.height = 55,
    this.width = 233,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      width: width,
      height: height,
      child: Text(
        text,
        style: MyStyles.of(context).textThemes.buttonActionText1,
      ),
      gradient: MyStyles.of(context).colors.accentGradient,
      onPressed: onPressed,
    );
  }
}

enum StyleTextFieldStatus {
  neutral,
  error
}

class StyleTextField extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String placeholderText;
  final int maxLines;

  StyleTextField({this.maxLines = 1, @required this.placeholderText, this.onChanged, this.onSubmitted}) : super();

  @override
  _StyleTextFieldState createState() => _StyleTextFieldState(
      maxLines: this.maxLines,
      placeholderText: this.placeholderText,
      status: StyleTextFieldStatus.neutral,
      onChanged: (string){print("ROAR");},
      onSubmitted: onSubmitted
  );
}

class _StyleTextFieldState extends State<StyleTextField> {
  final StyleTextFieldStatus status;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String placeholderText;
  final int maxLines;

  TextEditingController _controller;

  Color get borderColor {
    switch (status) {
      case StyleTextFieldStatus.neutral:
        return Colors.transparent;
      case StyleTextFieldStatus.error:
        return Colors.red;
    }
  }

  Alignment get textFieldFontAlignment {
    if (maxLines == 1) {
      return Alignment.center;
    } else {
      return Alignment.topLeft;
    }
  }

  _StyleTextFieldState({this.maxLines, this.placeholderText, @required this.status, this.onChanged, this.onSubmitted}) : super();

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: textFieldFontAlignment,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyStyles.of(context).colors.background1,
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2))
            ]
        ),
        padding: EdgeInsets.only(left: 10),
        child: TextField(
            controller: _controller,
            onChanged: (string){onChanged(string);},
            onSubmitted: onSubmitted,
            maxLines: maxLines,
            cursorColor: MyStyles.of(context).colors.accent,
            style: MyStyles.of(context).textThemes.placeholder.copyWith(color: Colors.grey[900]),
            decoration: InputDecoration(
                hintStyle: MyStyles.of(context).textThemes.placeholder,
                border: InputBorder.none,
                hintText: placeholderText
            )
        ),
      ),
    );
  }
}

