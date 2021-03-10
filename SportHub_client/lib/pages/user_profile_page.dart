import 'package:SportHub_client/utils/card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(backgroundColor: Colors.black, title: Text("yan_pershay")),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 7),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Yan Pershay",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 17,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Minsk',
                                  style: TextStyle(
                                      color: Colors.white, wordSpacing: 4)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 38.0, left: 38, top: 15, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('17k',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Text(
                          'followers',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                  Container(
                    color: Colors.white,
                    width: 0.2,
                    height: 22,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('387',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        Text(
                          'following',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                  Container(
                    color: Colors.white,
                    width: 0.2,
                    height: 22,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(33)),
                        gradient: LinearGradient(
                            colors: [Color(0xff66D0EB5), Color(0xff4059F1)],
                            begin: Alignment.bottomRight,
                            end: Alignment.centerLeft)),
                    child: Text('follow',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Level: Newer',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: Text(
                        "About: I'm a super sportsman with 10 years experience",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: Text(
                        "Motivation: I'd like to be dry jock.",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: Text(
                        'Height: 178 sm, Weight: 74 kg',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: Text(
                        'Birthday: 27.01.2000',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(34))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 33, right: 25, left: 25),
                      child: Text(
                        'Publications',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 33),
                      ),
                    ),
                    Container(
                      height: 250,
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => CardItem()),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
