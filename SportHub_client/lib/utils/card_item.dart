import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: 350,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                  title: Text("yan_pershay"),
                  subtitle: Text("Newer"),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/running.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(height: 14),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text(
                        "My first train! I should train every day",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                    ]),
                SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.thumb_up,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text("55")
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: <Widget>[
                        Icon(Icons.comment),
                        SizedBox(width: 8),
                        Text("12")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(width: 230),
                        Icon(Icons.bookmark),
                        SizedBox(width: 8)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 12),
              ],
            )));
  }
}
