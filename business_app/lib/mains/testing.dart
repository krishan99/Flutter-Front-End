// Flutter code sample for FlexibleSpaceBar

// This sample application demonstrates the different features of the
// [FlexibleSpaceBar] when used in a [SliverAppBar]. This app bar is configured
// to stretch into the overscroll space, and uses the
// [FlexibleSpaceBar.stretchModes] to apply `fadeTitle`, `blurBackground` and
// `zoomBackground`. The app bar also makes use of [CollapseMode.parallax] by
// default.

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Available seats'),
            ),
            actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Add new entry',
            onPressed: () {/* ... */},
          ),
        ]
      )
    );
  }
}
