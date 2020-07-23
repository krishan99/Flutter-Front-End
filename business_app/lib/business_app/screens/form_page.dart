import 'dart:collection';

import 'package:business_app/components/buttons.dart';
import 'package:business_app/components/textfields.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/theme/themes.dart';

class FormPageDataElementProtocol {}

class FormFieldData implements FormPageDataElementProtocol {
  String title;
  String placeholderText;
  String initialText;
  int maxLines;
  final String Function(String) checkError;
  TextEditingController controller = TextEditingController();

  String get text {
    return controller.text;
  }

  FormFieldData({
    this.title,
    this.maxLines,
    this.checkError,
    this.initialText,
    @required this.placeholderText
  });
}

class CheckBoxFormData implements FormPageDataElementProtocol {
  String title;
  bool isOn;

  CheckBoxFormData({@required this.title, this.isOn = false});
}

enum FormPageDataElementType {
  checkbox,
  textfield
}

class FormPageDataElement {
  FormPageDataElementType type;
  FormFieldData textfield;
  CheckBoxFormData checkbox;

  factory FormPageDataElement.textfield(FormFieldData textfield) {
    return FormPageDataElement(type: FormPageDataElementType.textfield, textfield: textfield);
  }

  factory FormPageDataElement.checkbox(CheckBoxFormData checkbox) {
    return FormPageDataElement(type: FormPageDataElementType.checkbox, checkbox: checkbox);
  }

  FormPageDataElement({this.type, this.textfield, this.checkbox});
}

class FormPageData extends ListBase<FormPageDataElement> {
  List<FormPageDataElement> _data;

  int get length => _data.length;

  set length(int newLength) {
    _data.length = newLength;
  }

  @override
  FormPageDataElement operator [](int index) {
      return _data[index];
    }
  
  @override
  void operator []=(int index, FormPageDataElement value) {
    _data[index] = value;
  }

  FormPageData(List<FormPageDataElement> data) {
    this._data = data;
  }
}

class FormPage extends StatefulWidget {
  final String title;
  final String subheading;
  final FormPageData formPageData;
  final Future<void> Function(FormPageData) onPressed;
  final void Function() onSuccess;

  FormPage({
    Key key,
    @required this.title,
    this.subheading,
    @required this.formPageData,
    this.onPressed,
    this.onSuccess,
  }) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  @override
  void initState() {
    super.initState();
    widget.formPageData.where((element) => element.type == FormPageDataElementType.textfield).map((field) => field.textfield.controller = TextEditingController(text: field.textfield.initialText));
  }

  @override
  void dispose() {
    super.dispose();
    widget.formPageData.where((element) => element.type == FormPageDataElementType.textfield).map((field) => field.textfield.controller.dispose());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyStyles.of(context).colors.background1,
        body: TappableFullScreenView(
          body: SafeArea(
            child: Container(
              color: MyStyles.of(context).colors.background1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: MyStyles.of(context).textThemes.h2,
                          )
                        ),
                        if (widget.subheading != null) 
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: Text(
                                  widget.subheading,
                                  textAlign: TextAlign.center,
                                  style: MyStyles.of(context).textThemes.h3,
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    // color: Colors.red,
                    // alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.formPageData.map((element) {
                        return Column(
                          children: <Widget>[
                            (() {
                              switch (element.type) {
                                case FormPageDataElementType.textfield:
                                  final textField = element.textfield;
                                  return Column(
                                    children: <Widget>[
                                      if (textField.title != null && textField.title.isNotEmpty)
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(textField.title, textAlign: TextAlign.start, style: MyStyles.of(context).textThemes.bodyText3)
                                      ),
                                  
                                      StyleTextField(
                                        controller: textField.controller,
                                        placeholderText: textField.placeholderText,
                                        maxLines: textField.maxLines,
                                        getErrorMessage: textField.checkError,
                                      ),
                                    ],
                                  );

                                case FormPageDataElementType.checkbox:
                                  final checkboxData = element.checkbox;
                                  return CheckboxListTile(
                                    title: Text(checkboxData.title, style: MyStyles.of(context).textThemes.bodyText2),
                                    controlAffinity: ListTileControlAffinity.trailing,
                                    value: checkboxData.isOn,
                                    onChanged: (bool value) {
                                      setState(() {
                                        checkboxData.isOn = value;  
                                      });
                                    },
                                  );
                                }            
                            } ()),
                            SizedBox(height: 12),
                          ],
                        );             
                      }).toList()
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.center,
                    child: Consumer<User>(
                      builder: (context, user, _) {
                        return AccentedActionButton(
                          width: 233,
                          height: 55,
                          text: "Continue",
                          onPressed: () async {
                            await widget.onPressed(widget.formPageData);
                          },

                          onSuccess: widget.onSuccess,
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}