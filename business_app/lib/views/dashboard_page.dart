import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/model_data.dart';
import 'package:business_app/style_elements.dart';
import 'package:business_app/themes.dart';

class DashboardPage extends StatelessWidget {
  final String name;

  const DashboardPage({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideableList(
      header: SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
          color: MyStyles.of(context).colors.background2,
          name: name,
          minExtent: 100.0,
          maxExtent: 125,
        ),
      ),
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String name;
  final double minExtent;
  final double maxExtent;

  const _SliverAppBarDelegate(
      {this.color, this.name, this.minExtent, this.maxExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return Container(
      color: color,
      child: Column(children: <Widget>[
        ProfileAppBar(
          name: name,
        ),
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
  final String name;
  final Color color;

  const ProfileAppBar({
    Key key,
    this.color,
    @required this.name,
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
                      Text(
                        name,
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
      ],
    );
  }
}


