import 'package:SportHub_client/entities/admin_post.dart';
import 'package:SportHub_client/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          padding: const EdgeInsets.only(left: 13, top: 12, bottom: 12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.80,
                          child: Text(
                            widget.adminPost.title,
                            style: TextStyle(
                                fontSize: 30.r,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.8)),
                            softWrap: true,
                          ),
                        ),
                        IconButton(
                            iconSize: 40,
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
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
