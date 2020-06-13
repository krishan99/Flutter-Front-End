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

            SidableListCell()
          ],
        ),
      ),
    );
  }
}

class SidableListCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: Text('roar'),
            foregroundColor: Colors.white,
          ),
          title: Text('Tile nnow'),
          subtitle: Text('SlidableDrawerDelegate'),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => print('Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => print('Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => print('More'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('Delete'),
        ),
      ],
    ));
  }
}
