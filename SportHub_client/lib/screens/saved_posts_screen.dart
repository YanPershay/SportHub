import 'package:SportHub_client/entities/post.dart';
import 'package:SportHub_client/entities/saved_post.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/card_item.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    foregroundColor: Colors.black,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    title: Text(
                      "Saved posts",
                      style: GoogleFonts.workSans(
                          fontStyle: FontStyle.normal,
                          fontSize: 25.r,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )),
                backgroundColor: Colors.white,
                body: Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    title: Text(
                      "Сохранено",
                      style: GoogleFonts.workSans(
                          fontStyle: FontStyle.normal,
                          fontSize: 25.r,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
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
