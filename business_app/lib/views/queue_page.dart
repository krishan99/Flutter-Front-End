
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:business_app/model_data.dart';
import 'package:business_app/style_elements.dart';
import 'package:business_app/themes.dart';

class QueuePage extends StatelessWidget {
  final String name;

  const QueuePage({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 7,),
                      Text("Outdoor Line", style: MyStyles.of(context).textThemes.h2,),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.settings, size: 30)
                        )
                      )
                    ],
                  ),
                  Row(children: [
                    SizedBox(width: 42),
                    Text("Code: 543-23", style: MyStyles.of(context).textThemes.h4,)
                  ],),
                ],
              ),
              SizedBox(height: 7),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Waiting 20 | Notified 2 | Completed", 
                  style: MyStyles.of(context).textThemes.bodyText3,)
              )
            ],
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

