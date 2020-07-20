import 'package:business_app/business_app/models/queues.dart';
import 'package:business_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/business_app/models/models.dart';
import 'package:business_app/components/components.dart';
import 'package:business_app/theme/themes.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllQueuesInfo>(
      builder: (context, qinfo, _) {
        return FutureBuilder(
          initialData: "loading queues...",
          future: qinfo.retrieveServer(),
          builder: (context, snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Text('Loading queues...');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return SlideableList(
                    onPlusTap: () async {
                      try {
                        await qinfo.makeQueue("Big big fish", "roar roar road");
                      } catch (error){};
                    },

                    header: SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        color: MyStyles.of(context).colors.background2,
                        minExtent: 50.0,
                        maxExtent: 125,
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
                            user.name,
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


