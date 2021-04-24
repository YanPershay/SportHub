import 'dart:convert';

import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/saved_post.dart';
import 'package:SportHub_client/entities/user_info.dart';
import 'package:SportHub_client/screens/notifications/notifications_screen.dart';
import 'package:SportHub_client/utils/card_item.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  UserInfo userInfo;
  List<Post> userPosts = [];
  Box box;

  Future openBox() async {
    await Hive.initFlutter();
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('userPosts');
    return;
  }

  List data = [];

  Future<bool> getFeedPosts() async {
    await openBox();

    try {
      var response =
          await Dio().get(ApiEndpoints.subscribesPostsGET + SharedPrefs.userId);
      //userPosts = (response.data as List).map((x) => Post.fromJson(x)).toList();

      await putData(response.data);
    } catch (SocketException) {
      print("No internet");
    }

    var myMap = box.toMap().values.toList();

    if (myMap == null) {
      data.add("empty");
    } else {
      //data = myMap;
      userPosts = myMap.map((x) => Post.fromJson(x)).toList();
    }
    return Future.value(true);
  }

  Future putData(userPosts) async {
    await box.clear();
    for (var d in userPosts) {
      box.add(d);
    }
  }

  List<SavedPost> savedPosts = [];
  Future<void> getSavedPosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.savedPostsListGET + SharedPrefs.userId);
      savedPosts =
          (response.data as List).map((x) => SavedPost.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePosts() async {
    try {
      var response =
          await Dio().get(ApiEndpoints.subscribesPostsGET + SharedPrefs.userId);
      //userPosts = (response.data as List).map((x) => Post.fromJson(x)).toList();

      await putData(response.data);
      setState(() {
        var myMap = box.toMap().values.toList();
        userPosts = myMap.map((x) => Post.fromJson(x)).toList();
      });
    } catch (SocketException) {
      Toast.show("No internet", context);
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
                      "Feed",
                      style: TextStyle(color: Colors.black),
                    )),
                body: Container(
                  child: RefreshIndicator(
                    onRefresh: updatePosts,
                    child: ListView.builder(
                        itemCount: userPosts.length,
                        itemBuilder: (context, index) => CardItem(
                              post: userPosts[index],
                              userInfo: userPosts[index].user.userInfo,
                              savedPosts: savedPosts,
                            )),
                  ),
                ));
          }
        });
  }
}
