import 'package:SportHub_client/entities/admin_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminPostScreen extends StatefulWidget {
  AdminPost adminPost;

  AdminPostScreen({Key, key, @required this.adminPost});

  @override
  State<StatefulWidget> createState() {
    return AdminPostScreenState();
  }
}

class AdminPostScreenState extends State<AdminPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.adminPost.title,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.8))),
                    Text(
                      DateFormat('dd.MM.yyyy kk:mm')
                          .format(DateTime.parse(widget.adminPost.dateCreated)),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )
                  ],
                ),
                Text("by " + widget.adminPost.user.username)
              ]),
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.adminPost.imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Topic of this article is " + widget.adminPost.title,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ),
        new Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: new Text(
                  widget.adminPost.text,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )),
      ],
    ));
  }
}
