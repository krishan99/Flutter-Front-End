import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Color color;
  final double width;
  final double height;
  final Function onSuccess;

  const ActionButton(
      {Key key,
      @required this.child,
      this.gradient,
      this.color = Colors.grey,
      this.width = 233,
      this.height = 55,
      this.onSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
          borderRadius: BorderRadius.circular(30)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onSuccess,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

class AccentedActionButton extends StatefulWidget {
  final double height;
  final double width;
  final String text;
  final Function onPressed;
  final Function onSuccess;

  AccentedActionButton(
    {Key key,
    @required this.text,
    this.height = 55,
    this.width = 233,
    this.onSuccess,
    this.onPressed})
    : super(key: key);

  @override
  _AccentedActionButtonState createState() => _AccentedActionButtonState();
}

class _AccentedActionButtonState extends State<AccentedActionButton> {

  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Column(
        children: [
          ActionButton(
            height: widget.height,
            child: Text(
              widget.text,
              style: MyStyles.of(context).textThemes.buttonActionText1,
            ),
            gradient: MyStyles.of(context).colors.accentGradient,
            onSuccess: () async {
              try {
                if (widget.onPressed != null) {
                  await widget.onPressed();
                }

                if (widget.onSuccess != null) {
                  await widget.onSuccess();
                }

                setState(() {
                  this.errorMessage = null;
                });
              } catch (error) {
                setState(() {
                  this.errorMessage = error.toString();
                });
              } 
            },
          ),
          if (this.errorMessage != null)
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                this.errorMessage,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: MyStyles.of(context).textThemes.errorSubText
              )
            )
        ],
      ),
    );
  }
}