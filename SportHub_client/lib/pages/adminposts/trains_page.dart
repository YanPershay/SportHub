import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainsPage extends StatefulWidget {
  @override
  TrainsPageState createState() => TrainsPageState();
}

class TrainsPageState extends State<TrainsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text("Trains")),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: buildCard(),
    );
  }

  Widget buildCard() {
    List<String> assets = [
      "assets/running.jpg",
      "assets/running.jpg",
      "assets/running.jpg",
      "assets/running.jpg"
    ];
    return SingleChildScrollView(
        child: Column(children: [
      for (var i in assets)
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(
              children: [
                Ink.image(
                  image: AssetImage(i),
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    'Hard train',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24),
                  ),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.all(16).copyWith(bottom: 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(text: 'Duration: '),
                            //for (int i = 0; i > 3; i++)
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(18).copyWith(bottom: 10),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(text: 'Complexity: '),
                            //for (int i = 0; i > 3; i++)
                            WidgetSpan(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                )),
          ]),
        )
    ]));
  }
}
