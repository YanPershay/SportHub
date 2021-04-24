import 'package:SportHub_client/entities/admin_post.dart';
import 'package:SportHub_client/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminPostScreen extends StatefulWidget {
  final AdminPost adminPost;

  AdminPostScreen({@required this.adminPost});

  @override
  State<StatefulWidget> createState() {
    return AdminPostScreenState();
  }
}

class AdminPostScreenState extends State<AdminPostScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
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
                    Container(
                      width: SizeConfig.screenWidth * 0.85,
                      child: Text(
                        widget.adminPost.title,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.8)),
                        softWrap: true,
                      ),
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy kk:mm')
                          .format(DateTime.parse(widget.adminPost.dateCreated)),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text("by " + widget.adminPost.user.username)
                  ],
                ),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            widget.adminPost.text,
            style: TextStyle(fontSize: 20),
          ),
        ),
        //),
        // )//),
      ],
    )));
  }
}
