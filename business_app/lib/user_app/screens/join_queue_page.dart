import 'package:business_app/components/components.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:business_app/user_app/models/models.dart';
import 'package:business_app/user_app/services/services.dart';
import 'package:business_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinQueuePage extends StatefulWidget {
  @override
  _JoinQueuePageState createState() => _JoinQueuePageState();
}

class _JoinQueuePageState extends State<JoinQueuePage> {
  UAppServer _server;

  String _fullName = "John Doe";
  String _phoneNumber = "Phone Number";
  String _notes = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _server = Provider.of<UAppServer>(context);
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      decoration: BoxDecoration(
                          color: MyStyles.of(context).colors.accent),
                      padding: EdgeInsets.all(5),
                      child: Consumer<ApiResponse<QueueReqs>>(
                          builder: (context, response, _) {
                        String code;
                        switch (response.status) {
                          case Status.LOADING:
                          case Status.ERROR:
                            code = "Invalid Queue Code";
                            break;
                          case Status.COMPLETED:
                            code = response.data.code;
                            break;
                        }

                        return Text(
                          code,
                          textAlign: TextAlign.center,
                          style: MyStyles.of(context)
                              .textThemes
                              .bodyText2
                              .copyWith(color: Colors.white),
                        );
                      })),
                ),
                Text(
                  "Join Queue for EndLine",
                  style: MyStyles.of(context)
                      .textThemes
                      .h3
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                StyleTextField(
                  onChanged: (value) => {_fullName = value},
                  placeholderText: "Full Name"
                ),
                StyleTextField(
                  onChanged: (value) => {_phoneNumber = value},
                  placeholderText: "Phone Number"
                ),
                StyleTextField(
                  onChanged: (value) => {_notes = value},
                  placeholderText: "Notes"
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  color: Colors.transparent,
                  child: Consumer<QueueReqs>(
                    builder: (context, reqs, _) {
                      return LoadingButton(
                        defaultWidget: Text("Submit",
                            style: MyStyles.of(context).textThemes.buttonActionText2),
                        onPressed: () async {
                          bool success = false;
                          try {
                            await _server.addToQueue(qid: reqs.qid, name: _fullName, phoneNumber: _phoneNumber);
                            success = true;
                          } catch (e) {
                            showErrorDialog(context, title: "Houston we have a problem.", body: e.toString());
                          }
                          return (){
                            if (success) {
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
    ));
  }
}
