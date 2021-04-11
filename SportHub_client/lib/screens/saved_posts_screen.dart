import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/card_item.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SavedPostsScreen extends StatefulWidget {
  @override
  _SavedPostsScreenState createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  List<Post> savedPosts;

  Future<void> getFeedPosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.savedPostsGET + SharedPrefs.userId);
      savedPosts =
          (response.data as List).map((x) => Post.fromJson(x)).toList();
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
                        backgroundColor: Colors.white,
                        title: Text(
                          "Saved posts",
                          style: TextStyle(color: Colors.black),
                        )),
                    body: ListView.builder(
                        itemCount: savedPosts.length,
                        itemBuilder: (context, index) => CardItem(
                              post: savedPosts[index],
                              userInfo: savedPosts[index].user.userInfo,
                            ))),
              ));
        });
  }
}