import 'dart:convert';

import 'package:SportHub_client/entities/user.dart';
import 'package:SportHub_client/entities/utilsEntities/my_subs_helper.dart';
import 'package:SportHub_client/entities/utilsEntities/subs_helper.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SubscribersWidget extends StatefulWidget {
  final List subscribes;
  //final List subscribesResponse;

  //List<User> subscribers;
  //List<SubsHelper> subscribersResponse;

  SubscribersWidget({
    Key key,
    this.title,
    @required this.subscribes,
    //@required this.subscribesResponse,
    //@required this.subscribers,
    //@required this.subscribersResponse
  }) : super(key: key);

  final String title;

  @override
  SubscribersWidgetState createState() => new SubscribersWidgetState();
}

class SubscribersWidgetState extends State<SubscribersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          itemCount: widget.subscribes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: widget.subscribes[index].userInfo.avatarUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              title: Text(widget.subscribes[index].username),
              subtitle: Text(widget.subscribes[index].userInfo.sportLevel),
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
