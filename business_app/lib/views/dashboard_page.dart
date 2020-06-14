import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/model_data.dart';
import 'package:business_app/style_elements.dart';
import 'package:business_app/themes.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Queues>(
      builder: (context, queues, _) {
        return SlideableList(
          header: SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              color: MyStyles.of(context).colors.background2,
              minExtent: 50.0,
              maxExtent: 125,
            ),
          ),
          cells: queues.map((element) =>
           ChangeNotifierProvider.value(
             value: element,
             child: Consumer<Queue>(
               builder: (context, queue, _) {
                 return QueueCell(
                   queue: queue,
                   onDelete: () async {
                     return Future.value(false);
                   },

                   onOpen: () async {
                      Navigator.of(context).pushNamed("/queue", arguments: queue);
                      return Future.value(false);
                   },
                  );
               },
             )
           )
          ).toList(),
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


