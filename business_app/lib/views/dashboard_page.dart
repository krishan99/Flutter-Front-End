import 'package:business_app/model_data.dart';
import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DashboardPage extends StatelessWidget {
  final String name;

  const DashboardPage({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              height: 37,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: MyStyles.of(context).images.userAccountIcon,
                  ),
                  
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: MyStyles.of(context).textThemes.h3,),
                            Text("View Account", style: MyStyles.of(context).textThemes.h5,)
                          ],
                        ),
                    ),
                  ),

                  Consumer<User>(
                    builder: (context, user, _) {
                      return GestureDetector(
                        onTap: () => {
                          user.signOut()
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: MyStyles.of(context).images.gearIcon
                        ),
                      );
                    },
                  )
                ],
              ),
            ),

            Container(
              child: Text("Dashboard", style: MyStyles.of(context).textThemes.h2,)
            )
          ],
        ),


      ),
    );
  }
}