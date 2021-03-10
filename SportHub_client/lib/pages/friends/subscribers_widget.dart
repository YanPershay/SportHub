import 'package:SportHub_client/pages/friends/user.dart';
import 'package:flutter/material.dart';

class SubscribersWidget extends StatefulWidget {
  SubscribersWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SubscribersWidgetState createState() => new SubscribersWidgetState();
}

class SubscribersWidgetState extends State<SubscribersWidget> {
  User user =
      new User(0, "About me", "yan_pershay", "Newer", "assets/profile.jpg");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        title: new Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: TextFormField(
            decoration: InputDecoration(hintText: "Search..."),
          ),
        ),
        Expanded(
            child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(user.picture),
              ),
              title: Text(user.name),
              subtitle: Text(user.level),
              trailing: RaisedButton(
                color: Colors.black,
                child: Text(
                  'Subscribe',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => {},
              ),
            );
          },
        ))
      ]),
    );
  }
}
