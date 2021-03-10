import 'package:SportHub_client/pages/friends/subscribers_widget.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  @override
  FriendsPageState createState() => FriendsPageState();
}

class FriendsPageState extends State<FriendsPage> {
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Friends",
            style: TextStyle(color: Colors.black),
          )),
      body: PageView(
        controller: controller,
        children: <Widget>[
          SubscribersWidget(
            title: "Subscribers",
          ),
          SubscribersWidget(
            title: "Subscribes",
          ),
        ],
      ),
    );
  }
}
