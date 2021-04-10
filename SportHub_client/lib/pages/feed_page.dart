import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/screens/notifications/notifications_screen.dart';
import 'package:SportHub_client/utils/card_item.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  UserInfo userInfo;
  List<Post> userPosts;

  Future<void> getFeedPosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.subscribesPostsGET + SharedPrefs.userId);
      userPosts = (response.data as List).map((x) => Post.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getFeedPosts()]),
        builder: (context, snapshot) {
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
                                        builder: (context) =>
                                            NotificationsScreen()));
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
                        itemCount: userPosts.length,
                        itemBuilder: (context, index) => CardItem(
                              post: userPosts[index],
                              userInfo: userPosts[index].user.userInfo,
                            ))),
              ));
        });
  }
}
