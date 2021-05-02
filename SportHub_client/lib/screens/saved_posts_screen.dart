import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/saved_post.dart';
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

  List<SavedPost> mySavedPosts = [];
  Future<void> getSavedPosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.savedPostsListGET + SharedPrefs.userId);
      mySavedPosts =
          (response.data as List).map((x) => SavedPost.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([getFeedPosts(), getSavedPosts()]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Wait");
          } else {
            return Scaffold(
                appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: Text(
                      "Saved posts",
                      style: TextStyle(color: Colors.black),
                    )),
                body: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: savedPosts.length,
                    itemBuilder: (context, index) => CardItem(
                          post: savedPosts[index],
                          userInfo: savedPosts[index].user.userInfo,
                          savedPosts: mySavedPosts,
                        )));
          }
        });
  }
}
