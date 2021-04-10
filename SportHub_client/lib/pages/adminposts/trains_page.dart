import 'package:SportHub_client/entities/admin_post.dart';
import 'package:SportHub_client/pages/adminposts/admin_post_screen.dart';
import 'package:SportHub_client/utils/api_endpoints.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainsPage extends StatefulWidget {
  @override
  TrainsPageState createState() => TrainsPageState();
}

class TrainsPageState extends State<TrainsPage> {
  List<AdminPost> adminPosts;

  Future<void> getAdminPosts() async {
    try {
      var response = await Dio().get(ApiEndpoints.getAdminPostsGET);
      adminPosts =
          (response.data as List).map((x) => AdminPost.fromJson(x)).toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text("Trains")),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: buildCard(),
    );
  }

  Widget buildCard() {
    return FutureBuilder(
        future: Future.wait([getAdminPosts()]),
        builder: (context, snapshot) {
          return SingleChildScrollView(
              child: Column(children: [
            for (var adminPost in adminPosts)
              GestureDetector(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPostScreen(
                                      adminPost: adminPost,
                                    )))
                      },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: adminPost.imageUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            left: 16,
                            child: Text(
                              adminPost.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(16).copyWith(bottom: 0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: 'Duration: ' +
                                              adminPost.duration.toString() +
                                              '/5'),
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.all(18).copyWith(bottom: 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: 'Complexity: ' +
                                              adminPost.complexity.toString() +
                                              '/5'),
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          )),
                    ]),
                  ))
          ]));
        });
  }
}
