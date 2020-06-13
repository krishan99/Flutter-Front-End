import 'package:business_app/model_data.dart';
import 'package:business_app/style_elements.dart';
import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: Have "SilvePersistentHeader" resize to allow smaller button while scrolling down. Using Temp Button rn.

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
      floatingActionButton: AccentedActionButton(text: "+", width: 50, height: 50,),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: CustomScrollView(slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                color: MyStyles.of(context).colors.background2,
                name: widget.name,
                minExtent: 100.0,
                maxExtent: 125,
              ),
            ),

            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              if (index != 0) {
                return null;
              }

              return Container(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyStyles.of(context).colors.background1,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          )
                        ] +
                        List.generate(3, (index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                            child: SlidableListCell(
                              isSelected: index == 0,
                              isActive: index % 2 == 0,
                              title: "Outdoor Line",
                              subheading: "20 People in Line",
                              body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididun",
                            )
                          );
                        })
                      ),
                    ),
                  ],
                ),
              );
            })),
          ]),
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


