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

enum StyleTextFieldType {
  email, password
}

enum StyleTextFieldStatus {
  neutral,
  error
}

class StyleTextField extends StatefulWidget {
  final IconData icon;
  final StyleTextFieldStatus status;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String Function(String) checkError;
  final String placeholderText;
  final TextInputType textInputType;
  final bool obscureText;
  final int maxLines;

  factory StyleTextField.type({
    @required StyleTextFieldType type,
     StyleTextFieldStatus status = StyleTextFieldStatus.neutral,
      Function(String ) onChanged, 
      Function(String) onSubmitted,}) {

    switch (type) {
      case StyleTextFieldType.email:
        return StyleTextField(
          icon: Icons.email,
          textInputType: TextInputType.emailAddress,
          status: status,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          placeholderText: "Email...",
          maxLines: 1,
        );

      case StyleTextFieldType.password:
        return StyleTextField(
          icon: Icons.panorama_fish_eye,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          status: status,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          placeholderText: "Password...",
          
          checkError: (text) {
            if (text.length <= 5) {
              return "Password should contains more then 5 character";
            } else {
              return null;
            }
          },

          maxLines: 1,
        );
    }
  }

  const StyleTextField({Key key, this.obscureText = false, this.textInputType, this.icon, this.checkError, this.status = StyleTextFieldStatus.neutral, this.onChanged, this.onSubmitted, @required this.placeholderText, this.maxLines}) : super(key: key);

  @override
  _StyleTextFieldState createState() => _StyleTextFieldState();
}

class _StyleTextFieldState extends State<StyleTextField> {

  TextEditingController _controller;

  Color get borderColor {
    switch (widget.status) {
      case StyleTextFieldStatus.neutral:
        return Colors.transparent;
      case StyleTextFieldStatus.error:
        return Colors.red;
    }
  }

  Color get iconColor {
    switch (widget.status) {
      case StyleTextFieldStatus.neutral:
        return null;
      case StyleTextFieldStatus.error:
      return Colors.red;
    }
  }

  Alignment get textFieldFontAlignment {
    if (widget.maxLines != null && widget.maxLines <= 1) {
      return Alignment.center;
    } else {
      return Alignment.topLeft;
    }
  }

  EdgeInsets get insets {
    if (widget.icon == null) {
      return EdgeInsets.only(left: 10);
    } else {
      return null;
    }
  }

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
        padding: insets,
        child: TextFormField(
            controller: _controller,
            keyboardType: widget.textInputType,
            obscureText: widget.obscureText,
            onChanged: widget.onChanged,
            onFieldSubmitted: widget.onSubmitted,
            maxLines: widget.maxLines,
            cursorColor: Colors.blue,
            style: MyStyles.of(context).textThemes.placeholder.copyWith(color: Colors.grey[900]),
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                prefixIcon: (widget.icon != null)? Icon(widget.icon, color: iconColor): null,
                hintStyle: MyStyles.of(context).textThemes.placeholder,
                border: InputBorder.none,
                hintText: widget.placeholderText,
                errorText: (widget.checkError != null)? widget.checkError(_controller.text): null,
            )
        ),
      ),
    );
  }
}

