import 'dart:math';

import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/components/cells/queue_cell.dart';
import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/user.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';

import 'package:toast/toast.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllQueuesInfo>(
      builder: (context, qinfo, _) {
        qinfo.leaveRooms();
        return FutureBuilder(
          future: qinfo.retrieveServer(),
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Scaffold(
                  body: Container(
                    alignment: Alignment.center,
                    color: MyStyles.of(context).colors.background2,
                    child: Text("Loading Queues...", style: MyStyles.of(context).textThemes.bodyText2,),
                  )
                );
              default:
                if (snapshot.hasError)
                  return Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text('Error: ${snapshot.error.toString()}', style: MyStyles.of(context).textThemes.h2)
                  );
                else
                  return SlideableList(
                    topSpacing: 55,
                    buttonText: "Add Queue",
                    onPlusTap: () async{
                      try {
                        await qinfo.makeQueue("Big big fish ${Random().nextInt(50).toString()}", "roar roar road");
                      } catch (error) {
                        Toast.show(error.toString(), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                      }
                    },

                    header: SliverPersistentHeader(
                      pinned: false,
                      delegate: _SliverAppBarDelegate(
                        color: MyStyles.of(context).colors.background2,
                        minExtent: 60,
                        maxExtent: 130,
                      ),
                    ),

                    cells: qinfo.body.map((element) =>
                      ChangeNotifierProvider.value(
                        value: element,
                        child: Consumer<Queue>(
                          builder: (context, queue, _) {
                            return QueueCell(
                              queue: queue,
                              onDelete: () async {
                                try {
                                  await qinfo.deleteQueue(queue.id);
                                  return true;
                                } catch (error) {
                                  return false;
                                }
                              },

                              onOpen: () async {
                                  Navigator.of(context).pushNamed("/queue", arguments: queue);
                                  return false;
                              },

                              onTap: () {
                                  Navigator.of(context).pushNamed("/queue", arguments: queue);
                                  // return false;
                              }
                            );
                          },
                        )
                      )
                    ).toList(),
                  );
            }
          }
        );
      },
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final double minExtent;
  final double maxExtent;

  const _SliverAppBarDelegate(
      {this.color, this.minExtent, this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: Column(children: <Widget>[
        ProfileAppBar(),
        Expanded(
          child: Container(
            // padding: EdgeInsets.only(bottom: 70),
            alignment: Alignment.center,
            child: Text(
              "Dashboard",
              style: MyStyles.of(context).textThemes.h2,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ProfileAppBar extends StatelessWidget {
  final Color color;

  const ProfileAppBar({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: color,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          height: 37,
          // constraints: BoxConstraints(maxHeight: 37),
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
                      Consumer<User>(
                        builder: (context, user, _) {
                          return Text(
                            user.businessName ?? "Company Name",
                            style: MyStyles.of(context).textThemes.h3,
                          );
                        }
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
      ],
    );
  }
}
