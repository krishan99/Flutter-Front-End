import 'package:business_app/model_data.dart';
import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DashboardPage extends StatefulWidget {
  final String name;

  const DashboardPage({Key key, @required this.name}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                              Text(
                                widget.name,
                                style: MyStyles.of(context).textThemes.h3,
                              ),
                              Text(
                                "View Account",
                                style: MyStyles.of(context).textThemes.h5,
                              )
                            ],
                          ),
                        ),
                      ),
                      Consumer<User>(
                        builder: (context, user, _) {
                          return GestureDetector(
                            onTap: () => {user.signOut()},
                            child: Container(
                                padding: EdgeInsets.all(3),
                                child: MyStyles.of(context).images.gearIcon),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Text(
                  "Dashboard",
                  style: MyStyles.of(context).textThemes.h2,
                )),
              ],
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.8,
              maxChildSize: 0.9,
              builder: (context, _controller) {
                return Container(
                  color: MyStyles.of(context).colors.background1,
                  child: SingleChildScrollView(
                      controller: _controller,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: 
                            <Widget>[
                              SizedBox(height: 15)
                            ] + 
                            List.generate(2, (index) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                                  child: SidableListCell()
                                );
                              }
                            )
                        ),
                      )
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}

class SidableListCell extends StatelessWidget {
  static const double borderRadius = 20;
  final bool selected;

  const SidableListCell({Key key, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: (selected) ? Border.all(width: 1, color: MyStyles.of(context).colors.accent) : null,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Dismissible(
            key: GlobalKey(),
            confirmDismiss: (direction) {
              return Future.value(false);
            },

            background: Container(
              padding: EdgeInsets.all(15),
              color: MyStyles.of(context).colors.secondary,
              alignment: Alignment.centerLeft,
              child: Text(
                "Delete",
                style: MyStyles.of(context).textThemes.buttonActionText2,
              ),
            ),

            secondaryBackground: Container(
              padding: EdgeInsets.all(15),
              color: MyStyles.of(context).colors.accent,
              alignment: Alignment.centerRight,
              child: Text(
                "Notify",
                style: MyStyles.of(context).textThemes.buttonActionText2,
              ),
            ),
            child: Container(
              color: MyStyles.of(context).colors.background1,
              padding: EdgeInsets.all(20),
              child: Container(
                constraints: BoxConstraints(minHeight: 175),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Active",
                        textAlign: TextAlign.end,
                        style: MyStyles.of(context).textThemes.active,
                      ),
                      Text("Outdoor Line",
                          textAlign: TextAlign.left,
                          style: MyStyles.of(context).textThemes.bodyText1),
                      SizedBox(height: 5),
                      Text(
                        "20 People in Line",
                        style: MyStyles.of(context).textThemes.bodyText2,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veni",
                        style: MyStyles.of(context).textThemes.bodyText3,
                      )
                    ]
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
