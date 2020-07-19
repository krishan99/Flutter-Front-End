import 'package:business_app/business_app/models/queues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';


class queue_settings extends StatelessWidget {
  AllQueuesInfo qinfo;
  String queue_name;
  String queue_desc;

 queue_settings(AllQueuesInfo qinfo){
    this.qinfo = qinfo;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Queue"),
      ),
      body: Center(
        child: Container(
            color: MyStyles.of(context).colors.background1,
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                            flex: 1,
                            child: StyleTextField(
                              placeholderText: "Enter Queue Name",
                              onChanged: (string){
                                print("$string");
                                queue_name = string;
                              },
                            )
                        ),
                        SizedBox(height: 12,),
                        Flexible(
                            flex: 3,
                            child: StyleTextField(
                              placeholderText: "Enter Queue Description",
                              onChanged: (string){
                                queue_desc = string;
                                print("$string");
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                ),
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
            ),
          ),      
      ),
    );
  }
}