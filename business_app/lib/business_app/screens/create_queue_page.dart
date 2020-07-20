import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';

import 'package:toast/toast.dart';


class CreateQueue extends StatelessWidget {

  final AllQueuesInfo qinfo;
  String queue_name;
  String queue_desc;
  
  //ctr
  CreateQueue(this.qinfo);

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container (
          color: MyStyles.of(context).colors.background1,
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: <Widget>[
              Text("Create A Queue"),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: StyleTextField(
                      placeholderText: "Enter A Name For Your Queue",
                      onChanged: (string) {
                        print("$string");
                        queue_name = string;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children : [
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: StyleTextField(
                      placeholderText: "Enter A Description For Your Queue",
                      onChanged: (string) {
                        print("$string");
                        queue_desc = string;
                      },
                    )
                  ),
                ]
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      alignment: Alignment.center,
                      child: AccentedActionButton(
                        width: 233,
                        height: 55,
                        text: "Continue",
                        onPressed: () => {
                          qinfo.makeQueue(queue_name, queue_desc),
                          Navigator.pop(context),
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ) 
      )
    );
  }
}