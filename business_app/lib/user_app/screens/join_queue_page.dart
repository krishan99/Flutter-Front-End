import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/components/components.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:business_app/user_app/models/models.dart';
import 'package:business_app/user_app/services/services.dart';
import 'package:business_app/utils.dart';
import 'package:toast/toast.dart';

class JoinQueuePage extends StatelessWidget {

  static double columnSpacing = 15;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  QueueReqs reqs = QueueReqs(code: "invalid code", qid: 1, needsName: true, needsPhoneNumber: true);

  JoinQueuePage({
    Key key,
    this.reqs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TappableGradientScaffold(
        body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "EndLine",
                    style: MyStyles.of(context)
                        .textThemes
                        .h1
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                    child: Container(
                      decoration: BoxDecoration(color: MyStyles.of(context).colors.accent),
                      padding: EdgeInsets.all(5),
                      child: Text(
                          reqs.code,
                          textAlign: TextAlign.center,
                          style: MyStyles.of(context)
                              .textThemes
                              .bodyText2
                              .copyWith(color: Colors.white),
                        )
                    ),
                  ),
                  // Text(
                  //   "Join Queue for EndLine",
                  //   style: MyStyles.of(context)
                  //       .textThemes
                  //       .h3
                  //       .copyWith(color: Colors.white),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: columnSpacing,),
                  if (reqs.needsName)
                    StyleTextField(
                      controller: fullNameController,
                      placeholderText: "Full Name"
                    ),
                    SizedBox(height: columnSpacing,),
                  
                  if (reqs.needsPhoneNumber)
                    StyleTextField.phoneNumber(
                      controller: phoneNumberController,
                    ),
                    SizedBox(height: columnSpacing,),

                  StyleTextField(
                    controller: notesController,
                    placeholderText: "Notes (Optional)"
                  ),
                  SizedBox(height: columnSpacing,),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    color: Colors.transparent,
                    child: Consumer<UAppServer>(
                      builder: (context, server, _) {
                        return LoadingButton(
                          defaultWidget: Text("Submit",
                          style: MyStyles.of(context).textThemes.buttonActionText2),
                          onPressed: () async {
                            ApiResponse<void> apiResponse = await ApiResponse.fromFunction(() async {
                                await server.addToQueue(
                                  qid: reqs.qid,
                                  name: fullNameController.text, 
                                  phoneNumber: phoneNumberController.text
                                );
                              }
                            );

                            if (apiResponse.isError) {
                              Toast.show(apiResponse.message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }

                            return (){
                              if (apiResponse.isSuccess) {
                                  Navigator.of(context).pushNamed("/thankyou");                                 
                              }
                            };
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
