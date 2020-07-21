import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';
import 'package:business_app/user_app/components/components.dart';
import 'package:flutter/material.dart';

class SetupAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TappableFullScreenView(
        body: Container(
          color: MyStyles.of(context).colors.background1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Text(
                        "Sign Up Part 2",
                        textAlign: TextAlign.center,
                        style: MyStyles.of(context).textThemes.h2,
                      )),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        child: Text(
                          "This can be changed in settings.",
                          textAlign: TextAlign.center,
                          style: MyStyles.of(context).textThemes.h3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 3,
                child: Container(
                  // color: Colors.red,
                  // alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      StyleTextField(
                        placeholderText: "Enter Business Name",
                        onChanged: (string) {
                          print("$string");
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      StyleTextField(
                        placeholderText: "Enter Business Description",
                        maxLines: 6,
                        onChanged: (string) {
                          print("$string");
                        },
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
                    onSuccess: () async {
                      //TODO: Update User Description
                      Navigator.of(context).popAndPushNamed("/dashboard");
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

// import 'package:business_app/theme/themes.dart';
// import 'package:flutter/material.dart';
// import 'package:business_app/components/components.dart';

// import 'home_page.dart';

// class SignUpPage extends StatefulWidget implements EntranceScreen {
//   final double height;
//   SignUpPage.height({this.height});
//   SignUpPage({this.height});

//   @override
//   _SignUpPageState createState() => _SignUpPageState(height: this.height);
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final double height;

//   _SignUpPageState({this.height}) : super();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: GestureDetector(
//           onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
//           child: Container(
//             color: MyStyles.of(context).colors.background1,
//             constraints: BoxConstraints(maxHeight: height ?? MediaQuery.of(context).size.height),
//             child:
//           ),
//         ),
//       ),
//     );
//   }
// }
