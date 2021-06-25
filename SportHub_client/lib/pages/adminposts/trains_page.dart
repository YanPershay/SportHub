import 'package:SportHub_client/entities/admin_post.dart';
import 'package:SportHub_client/pages/adminposts/add_trainer_post_screen.dart';
import 'package:SportHub_client/pages/adminposts/admin_post_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:SportHub_client/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainsPage extends StatefulWidget {
  @override
  TrainsPageState createState() => TrainsPageState();
}

class TrainsPageState extends State<TrainsPage> {
  List<AdminPost> adminPosts = [];

  Future<void> getAdminPosts() async {
    try {
      var response = await Dio().get(ApiEndpoints.getAdminPostsGET);
      adminPosts =
          (response.data as List).map((x) => AdminPost.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  Widget addTrainerPostIcon() {
    return SharedPrefs.isAdmin
        ? IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 35.r,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTrainerPostScreen()));
            },
          )
        : Icon(null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          title: Text(
            "Blog",
            style: GoogleFonts.workSans(
                fontStyle: FontStyle.normal,
                fontSize: 25.r,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          actions: <Widget>[
            addTrainerPostIcon(),
            Container(
              width: 10.r,
            )
          ],
        ),
        backgroundColor: Colors.grey[900],
        resizeToAvoidBottomInset: false,
        body: buildCard(),
      ),
    );
  }

  Widget buildCard() {
    return SafeArea(
      child: FutureBuilder(
          future: Future.wait([getAdminPosts()]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              );
            } else {
              return adminPosts.isEmpty
                  ? Center(
                      child: Text("Sorry, something went wrong :(",
                          style: TextStyle(color: Colors.white)))
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        for (var adminPost in adminPosts)
                          GestureDetector(
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminPostScreen(
                                                  adminPost: adminPost,
                                                )))
                                  },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: adminPost.imageUrl,
                                            imageBuilder: (context, provider) =>
                                                Container(
                                              height: 200.r,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: provider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          Positioned(
                                            bottom: 16,
                                            right: 16,
                                            left: 16,
                                            child: Text(
                                              adminPost.title,
                                              style: GoogleFonts.workSans(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 25.r,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.workSans(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.r,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text: 'Duration: ' +
                                                            adminPost.duration
                                                                .toString() +
                                                            '/5'),
                                                  ],
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0)
                                            .copyWith(top: 0),
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.workSans(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.r,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text: 'Complexity: ' +
                                                            adminPost.complexity
                                                                .toString() +
                                                            '/5'),
                                                  ],
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ))
                      ]));
            }
          }),
    );
  }
}
