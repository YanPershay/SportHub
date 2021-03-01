import 'package:SportHub_client/utils/card_item.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feed app',
        theme: ThemeData(fontFamily: "Open Sans"),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
              body: ListView.builder(
                  itemCount: 4, itemBuilder: (context, index) => CardItem())),
        ));
  }
}
