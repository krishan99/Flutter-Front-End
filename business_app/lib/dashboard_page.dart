import 'package:business_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:business_app/style_elements.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page.dart';

class DashboardPage extends StatelessWidget {
  final String name;

  const DashboardPage({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 50,
          child: Row(
            children: [
              Container(
                child: MyStyles.of(context).images.userAccountIcon,
              ),
              
              Container(
                child: Column(
                  children: [
                    Text(name, style: MyStyles.of(context).textThemes.h3,),
                    Text("View Account", style: MyStyles.of(context).textThemes.h5,)
                  ],
                ),
              ),

              Container(
                child: MyStyles.of(context).images.gearIcon
              )
            ],
          ),
        ),
      ),
    );
  }
}