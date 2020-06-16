import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/services/services.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:business_app/user_app/models/models.dart';
import 'package:business_app/user_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QueueHandler _queueHandler;

  final _textFieldController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _queueHandler = Provider.of<QueueHandler>(context);
  }

  @override
  Widget build(BuildContext context) {

    return TappableGradientScaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("EndLine", style: MyStyles.of(context).textThemes.h1.copyWith(color: Colors.white),),
                SizedBox(height: 20),

                Consumer<ApiResponse<QueueReqs>>(
                  builder: (context, api, _) {
                    final isError = api.status == Status.ERROR;

                    return Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          constraints: BoxConstraints(maxWidth: 250),
                          child: StyleTextField(
                            placeholderText: "Enter Pin...",                            
                          ),
                        ),

                        () {
                          if (isError) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Invalid Queue Code", style: MyStyles.of(context).textThemes.subtext.copyWith(color: Colors.white)),
                            );
                          } else {
                            return Container();
                          }
                        } ()
                      ],
                    );
                  },
                  
                ),

                Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.transparent,
                  constraints: BoxConstraints(maxWidth: 200),
                  child: LoadingButton(
                        defaultWidget: Text("Submit", style: MyStyles.of(context).textThemes.buttonActionText2),
                        onPressed: () async {
                          await _queueHandler.updateQueueReqs(code: _textFieldController.value.text);
                          return () async {
                            Navigator.of(context).pushNamed("/join_queue");
                          };
                        },
                      ),

                ),

                // SizedBox(height: 20),
                Container(
                  child: Text("Need Help?", style: MyStyles.of(context).textThemes.h3.copyWith(color: Colors.white),),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomCenter,
            child: Text("Business Owner?", style: MyStyles.of(context).textThemes.h3.copyWith(color: Colors.white),)
          )
        ],
      ),
    );
  }
}