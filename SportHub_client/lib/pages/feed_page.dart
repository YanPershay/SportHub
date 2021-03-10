import 'package:SportHub_client/screens/notifications/notifications_screen.dart';
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
              appBar: AppBar(
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.notification_important_outlined,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationsScreen()));
                        },
                      ),
                    )
                  ],
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text(
                    "Feed",
                    style: TextStyle(color: Colors.black),
                  )),
              body: ListView.builder(
                  itemCount: 4, itemBuilder: (context, index) => CardItem())),
        ));
  }
}
