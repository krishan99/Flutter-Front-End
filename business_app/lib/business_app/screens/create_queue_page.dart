import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/business_app/screens/form_page.dart';
import 'package:business_app/components/buttons.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/components/textfields.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateQueue extends StatelessWidget {
  @override
  final AllQueuesInfo qinfo;

  CreateQueue(this.qinfo);
  Widget build(BuildContext context) {
    return FormPage(
      title: "Create a Queue",
      formPageData: FormPageData([
        FormPageDataElement.textfield(
          FormFieldData(
            placeholderText: "Enter Queue Name",
            checkError: (text) {
              if (text != null && text.length < 5) {
                return "Queue name must be at least 5 characters.";
              } else {
                return null;
              }
            }
          )
        ),
        
        FormPageDataElement.textfield(
          FormFieldData(
            placeholderText: "Enter Queue Description (Optional)",
            maxLines: 3
          )
        ),

        FormPageDataElement.checkbox(
          CheckBoxFormData(title: "Require Name", isOn: true)
        )
      ]),
      onPressed: (formData) async {
        final name = formData[0].textfield.text;
        final description = formData[1].textfield.text;
        final requireName = formData[2].checkbox.isOn;

        if (name.isEmpty) {
          throw CustomException("You must enter a queue name.");
        }

        qinfo.makeQueue(
          name: name,
          description: description,
          requireName: requireName,
        );
      },
      onSuccess: () => Navigator.pop(context),
    );
  }
}
